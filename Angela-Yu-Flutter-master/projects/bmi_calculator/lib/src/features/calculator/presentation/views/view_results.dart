import 'package:bmi_calculator/src/features/calculator/presentation/components/button_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewResults extends StatelessWidget {
  const ViewResults({
    super.key,
    required this.resultBMI,
    required this.resultText,
    required this.resultInterpretation,
  });

  final String resultBMI;
  final String resultText;
  final String resultInterpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Your result',
            style: TextStyle(
              fontSize: 40.0.w,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w.r),
                color: const Color.fromARGB(255, 27, 32, 59),
              ),
              padding:
                  EdgeInsets.symmetric(vertical: 60.0.h, horizontal: 10.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    resultText,
                    style: const TextStyle(color: Colors.green),
                  ),
                  Text(
                    resultBMI,
                    style: TextStyle(
                        fontSize: 60.0.w,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    resultInterpretation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0.w,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ButtonBottom(
            title: 'RE-CALCULATE',
            // onTap: () => Navigator.pop(context, resetValues),
          ),
        ],
      ),
    );
  }
}
