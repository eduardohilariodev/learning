import 'package:bmi_calculator/src/features/calculator/presentation/views/view_home.dart';
import 'package:bmi_calculator/src/features/calculator/presentation/views/view_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(
      const BMICalculator(),
    );

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData.dark();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: theme.copyWith(
            appBarTheme: const AppBarTheme(
              color: Color(0xFF0A0E21),
            ),
            scaffoldBackgroundColor: const Color(0xFF0A0e21),
            colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.purple,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Color(0xFF8D8E98),
              ),
            ),
          ),
          home: const ViewHome(),
        );
      },
    );
  }
}
