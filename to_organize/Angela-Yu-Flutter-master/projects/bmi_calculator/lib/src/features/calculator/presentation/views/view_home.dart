import 'package:bmi_calculator/src/constants/constants.dart';
import 'package:bmi_calculator/src/features/calculator/domain/calculator_bmi.dart';
import 'package:bmi_calculator/src/features/calculator/presentation/components/button_footer.dart';
import 'package:bmi_calculator/src/features/calculator/presentation/components/icon_content.dart';
import 'package:bmi_calculator/src/features/calculator/presentation/components/reusable_card.dart';
import 'package:bmi_calculator/src/features/calculator/presentation/views/view_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { female, male }

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  Gender? selectedGender;
  int height = 180;
  int weight = 80;
  int age = 19;

  void resetValues() {
    setState(() {
      height = 180;
      weight = 80;
      age = 19;
    });
  }

  @override
  void initState() {
    super.initState();
    resetValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onTap: () => setState(() {
                      selectedGender = Gender.male;
                    }),
                    color: selectedGender == Gender.male
                        ? colorCardActive
                        : colorCardInactive,
                    child: const IconContent(
                      icon: FontAwesomeIcons.mars,
                      title: 'Male',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onTap: () => setState(() {
                      selectedGender = Gender.female;
                    }),
                    color: selectedGender == Gender.female
                        ? colorCardActive
                        : colorCardInactive,
                    child: const IconContent(
                      icon: FontAwesomeIcons.venus,
                      title: 'Female',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: colorCardActive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('HEIGHT'),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(height.toString(), style: textStyleCounter),
                            const Text(' cm')
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.white,
                            thumbColor: const Color(0xFFEB1555),
                            overlayColor: const Color(0x29EB1555),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 15.0.w,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 30.0.w,
                            ),
                          ),
                          child: Slider(
                            min: 120.0.w,
                            max: 220.0.w,
                            value: height.toDouble(),
                            inactiveColor: const Color(0xFF8D8E98),
                            onChanged: (newHeight) => setState(() {
                              height = newHeight.toInt();
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: colorCardActive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('WEIGHT'),
                        Text(
                          weight.toString(),
                          style: textStyleCounter,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              onPressed: () => setState(() {
                                weight--;
                              }),
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(width: 10.0.w, height: 10.0.w),
                            RoundIconButton(
                              onPressed: () => setState(() {
                                weight++;
                              }),
                              icon: FontAwesomeIcons.plus,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: colorCardActive,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('AGE'),
                        Text(
                          age.toString(),
                          style: textStyleCounter,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              onPressed: () => setState(() {
                                age--;
                              }),
                              icon: FontAwesomeIcons.minus,
                            ),
                            SizedBox(width: 10.0.w, height: 10.0.w),
                            RoundIconButton(
                              onPressed: () => setState(() {
                                age++;
                              }),
                              icon: FontAwesomeIcons.plus,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonBottom(
            title: 'CALCULATE',
            onTap: () {
              CalculatorBMI calc =
                  CalculatorBMI(weight: weight, height: height);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewResults(
                    resultBMI: calc.calculateBMI(),
                    resultInterpretation: calc.getInterpretation(),
                    resultText: calc.getResult(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 56.0.w,
        height: 56.0.h,
      ),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      child: Icon(icon),
    );
  }
}
