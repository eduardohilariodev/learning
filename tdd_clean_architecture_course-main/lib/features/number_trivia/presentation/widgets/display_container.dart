import 'package:flutter/material.dart';

class DisplayContainer extends StatelessWidget {
   const DisplayContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: child,
      ),
    );
}
