import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class SocialPythonMain extends StatefulWidget {
  @override
  _SocialPythonMainState createState() => _SocialPythonMainState();
}

class _SocialPythonMainState extends State<SocialPythonMain> {
  File file;

  int interaction = 0;

  ProgressDialog pr;
  bool isSafe = true;

  String urlServer = 'https://58db55927678.ngrok.io';

  var uuid = Uuid();
  String pathReal;
  String lastKnownDistance = "0.00";

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  var ImagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    changeUrl();
  }

  void changeColor() {
    setState(() {
      isSafe = !isSafe;
    });
  }

  void changeUrl() async {
    await _updateUrlString();
  }

  Future<void> _updateUrlString() async {
    final response =
        await http.get('https://coronai-server-link.herokuapp.com/main');
    if (response.statusCode == 200) {
      Map<String, dynamic> urlData = jsonDecode(response.body);

      urlServer = urlData['link'];
      print(urlServer);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch Link');
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    pathReal = await _localFile;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  // Change onResume Functionality of Android Phones
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<String> get _localFile async {
    final path = await _localPath;
    return path;
  }

  void _openGallery() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      pathReal = await _localFile;

      file = File(pickedFile.path);
      String fileName = file.path.split('/').last;

      file = await testCompressAndGetFile(file, pathReal + fileName);
    } else {
      print('No image selected.');
    }
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 18,
    );

    return result;
  }

  Future<void> _getResult() async {
    final response = await http.get(urlServer + '/result');
    if (response.statusCode == 200) {
      Map<String, dynamic> distancedata = jsonDecode(response.body);

      lastKnownDistance = distancedata['distance'];

      if (lastKnownDistance.contains("no_image") ||
          lastKnownDistance.contains("no_match")) {
      } else {
        if (double.parse(lastKnownDistance) > 100) {
          setState(() {
            isSafe = true;
          });
        } else {
          setState(() {
            interaction++;
            isSafe = false;
          });
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> _updateFile() async {
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split('/').last;

    var result = await http.post(urlServer + '/image', body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.body);
      Future.delayed(const Duration(milliseconds: 1000), () async {
        await _getResult();
      });
    }).catchError((err) => print(err));
  }

  void onCaptureButtonPressed() async {
    //on camera button press
    try {
      String photoID = uuid.v4();
      final path = join(
        (await getTemporaryDirectory()).path, //Temporary path
        '$photoID.jpg',
      );
      await pr.show();

      ImagePath = path;
      await _controller.takePicture(path); //take photo

      file = File(ImagePath);
      String fileName = ImagePath.split('/').last;

      file = await testCompressAndGetFile(file, pathReal + '/' + fileName);

      await _updateFile();

      await pr.hide();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      backgroundColor: isSafe ? Colors.green : Colors.redAccent,
      floatingActionButton: FloatingActionButton(
        //onPressed: () => onCaptureButtonPressed(),
        onPressed: () => onCaptureButtonPressed(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              height: 500,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return Transform.scale(
                      scale: _controller.value.aspectRatio / deviceRatio,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: CameraPreview(_controller), //cameraPreview
                      ),
                    );
                  } else {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Otherwise, display a loading indicator.
                  }
                },
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Text(
                '$interaction Risks',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            Text(
              isSafe ? 'SAFE' : 'UNSAFE',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 60.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 3.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
