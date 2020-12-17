import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WearEssentials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Text(
            'Requirements',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 23.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildRequirementsContainer(
                  'Mask',
                  SvgPicture.asset('assets/icons/face-mask(2).svg'),
                  [Color(0XFFFF7442), Color(0XFFFF7442)]),
              _buildRequirementsContainer(
                  'Alcohol',
                  SvgPicture.asset(
                    'assets/icons/hand-sanitizer.svg',
                  ),
                  [Color(0XFF4D5CF0), Color(0XFF4D5CF0)]),
              _buildRequirementsContainer(
                  'Goggles',
                  SvgPicture.asset('assets/icons/goggles.svg'),
                  [Color(0XFFFF505D), Color(0XFFFF505D)]),
              _buildRequirementsContainer(
                  'Face Shield',
                  SvgPicture.asset('assets/icons/face-mask.svg'),
                  [Color(0XFFFACB39), Color(0XFFFACB39)]),
              SizedBox(
                width: 28.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildRequirementsContainer(
      String title, Widget iconSvg, List<Color> colors) {
    return Container(
      height: 150.0,
      width: 120.0,
      margin: EdgeInsets.only(
        left: 24.0,
        top: 10.0,
        bottom: 5.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            child: Image(
              height: 150.0,
              width: 120.0,
              fit: BoxFit.contain,
              image: AssetImage('assets/images/virus.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'NunitoSans',
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 50.0,
                  child: iconSvg,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
