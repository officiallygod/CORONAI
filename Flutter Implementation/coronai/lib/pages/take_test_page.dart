import 'package:coronai/models/test_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TakeTestPage extends StatefulWidget {
  @override
  _TakeTestPageState createState() => _TakeTestPageState();
}

class _TakeTestPageState extends State<TakeTestPage> {
  final List<TestModel> testModelList = [
    (new TestModel(
        title: 'Dry Cough', imagePath: 'assets/images/dry_cough_test.png')),
    (new TestModel(
        title: 'Runny Nose', imagePath: 'assets/images/runny_nose_test.png')),
    (new TestModel(
        title: 'Headache', imagePath: 'assets/images/headache_test.png')),
    (new TestModel(
        title: 'High Fever', imagePath: 'assets/images/fever_test.png')),
    (new TestModel(
        title: 'Chest Pain', imagePath: 'assets/images/chest_pain_test.png')),
    (new TestModel(
        title: 'Muscle Pain', imagePath: 'assets/images/muscle_pain.png')),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: mediaQuery.size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 55.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Covid-19',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 26.0,
                              letterSpacing: 1.1,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Symptoms',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontFamily: 'Nunito',
                              letterSpacing: 1.3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                height: 4.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              Container(
                                height: 4.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'These symptoms may \nappear 2-14 days after exposure.',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 160.0,
                        width: 160.0,
                        child: SvgPicture.asset(
                          "assets/icons/Drcorona.svg",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              physics:
                  NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: testModelList.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10.0),
              addAutomaticKeepAlives: true,
              itemBuilder: (BuildContext context, int index) {
                return TestCard(
                  title: testModelList[index].getTitle(),
                  image: testModelList[index].getImagePath(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TestCard extends StatelessWidget {
  final String title, image;

  TestCard({this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7.0,
            spreadRadius: 2.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: GridTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 130.0,
              width: 130.0,
              child: FittedBox(
                child: Image.asset(image),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                letterSpacing: 1.0,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
