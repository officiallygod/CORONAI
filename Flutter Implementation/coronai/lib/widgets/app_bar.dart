import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarNew extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: Theme.of(context).primaryColor,
                  child: Container(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Warrior',
                        applicationIcon: Image(
                          height: 60.0,
                          width: 50.0,
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                        applicationVersion: '1.3.1',
                        children: [
                          Text('Author: Allen Benny'),
                          Text('About: CS Engineer'),
                        ],
                      );
                    },
                    iconSize: 30.0,
                    color: Colors.white,
                    splashColor: Theme.of(context).primaryColor,
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
