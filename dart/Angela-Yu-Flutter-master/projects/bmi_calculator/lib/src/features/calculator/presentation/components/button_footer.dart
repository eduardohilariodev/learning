import 'package:bmi_calculator/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonBottom extends StatelessWidget {
  const ButtonBottom({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: colorContainerBottom,
        margin: EdgeInsets.only(top: 10.0.h),
        width: double.infinity,
        alignment: Alignment.center,
        height: heightContainerBottom,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
