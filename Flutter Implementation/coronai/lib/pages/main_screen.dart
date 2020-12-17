import 'package:coronai/pages/corona_screen_page.dart';
import 'package:coronai/pages/main_screen_page.dart';
import 'package:coronai/pages/take_test_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  MotionTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MotionTabBarView(
        controller: _tabController,
        children: <Widget>[
          CoronaScreenPage(),
          MainScreenPage(),
          TakeTestPage()
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        labels: ["Corona", "Home", "Test"],
        initialSelectedTab: "Home",
        tabIconColor: Colors.grey,
        tabSelectedColor: Colors.purpleAccent,
        onTabItemSelected: (int value) {
          setState(() {
            _tabController.index = value;
          });
        },
        icons: [
          FontAwesomeIcons.virus,
          Icons.home,
          FontAwesomeIcons.vial,
        ],
        textStyle: TextStyle(
          color: Colors.purple,
        ),
      ),
    );
  }
}
