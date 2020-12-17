class TestModel {
  final String title;
  final String imagePath;
  bool isSelected = false;

  TestModel({this.title, this.imagePath});

  String getTitle() {
    return this.title;
  }

  String getImagePath() {
    return this.imagePath;
  }

  void changeIsSelected() {
    isSelected = (isSelected == false) ? true : false;
  }
}
