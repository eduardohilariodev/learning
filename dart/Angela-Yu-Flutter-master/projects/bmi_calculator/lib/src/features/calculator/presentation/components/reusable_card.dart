import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.color,
    this.child,
    this.onTap,
  });

  final Color color;
  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(15.0.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0.w),
          ),
          height: 200.0.w,
          width: 170.0.w,
          child: child,
        ));
  }
}
