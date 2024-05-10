import 'package:flutter/material.dart';

/// A widget that indicates to the user that we are loading more posts.
class BottomLoader extends StatelessWidget {
  /// A widget that displays a loading indicator at the bottom of a list.
  ///
  /// This widget is typically used in conjunction with a [ListView] or
  /// [GridView] to indicate that more items are being loaded.
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
