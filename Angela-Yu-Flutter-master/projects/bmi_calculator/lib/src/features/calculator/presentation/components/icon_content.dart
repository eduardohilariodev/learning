import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconContent extends StatelessWidget {
  const IconContent({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 40.0.w,
        ),
        SizedBox(width: 15.0.w, height: 15.0.w),
        Text(
          title.toUpperCase(),
          style: TextStyle(fontSize: 18.0.w, color: const Color(0xFF8D8E98)),
        )
      ],
    );
  }
}
