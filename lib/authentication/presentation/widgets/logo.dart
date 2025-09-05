import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/theme/app_color.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'T',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'O',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'D',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'O',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'L',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    ' I',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/images/Group.svg'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'S',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'T',
                    style: TextStyle(
                      color: AppColors.lightPink,
                      fontSize: 40,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
