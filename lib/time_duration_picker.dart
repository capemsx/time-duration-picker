library time_duration_picker;

import 'package:flutter/material.dart';
import 'package:time_duration_picker/simple_time.dart';

import 'clock.dart';
import 'knob.dart';

class TimeDurationPicker extends StatelessWidget {
  final IconData icon1Data;
  final IconData icon2Data;
  final double diameter;
  final void Function(String) onIcon1RotatedCallback;
  final void Function(String) onIcon2RotatedCallback;
  final Color iconColor;
  final void Function(String)? setDurationCallback;
  final BoxDecoration? knobDecoration;
  final BoxDecoration? knobBackgroundDecoration;
  final BoxDecoration? clockDecoration;
  final TextStyle? clockTextStyle;
  /// First icon's initial value
  final SimpleTime? icon1InitialValue;

  /// Second icon's initial value
  final SimpleTime? icon2InitialValue;

  const TimeDurationPicker(
      {Key? key,
      required this.icon1Data,
      required this.icon2Data,
      required this.diameter,
      required this.onIcon1RotatedCallback,
      required this.onIcon2RotatedCallback,
      this.iconColor = Colors.white,
      this.knobDecoration,
      this.icon1InitialValue,
    this.icon2InitialValue,
      this.knobBackgroundDecoration,
      this.clockDecoration,
      this.clockTextStyle,
      this.setDurationCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double clockRatio = 0.6;
    double gapRatio = 0.05;
    double innerGapRatio = 0.175;
    double knobWidth = 0.175;
    double knobInnerRadiusRatio = clockRatio + innerGapRatio;
    double knobOuterRadiusRatio = knobInnerRadiusRatio + knobWidth;
    assert(knobInnerRadiusRatio < knobOuterRadiusRatio &&
        knobOuterRadiusRatio < 1);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (diameter <= constraints.maxWidth &&
          diameter <= constraints.maxHeight) {
        return Container(
            width: diameter,
            height: diameter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Knob(
                  radius: diameter,
                  innerRadiusRatio: knobInnerRadiusRatio,
                  outerRadiusRatio: knobOuterRadiusRatio,
                  onIcon1RotatedCallback: onIcon1RotatedCallback,
                  onIcon2RotatedCallback: onIcon2RotatedCallback,
                  icon1Data: icon1Data,
                  icon2Data: icon2Data,
                  iconColor: iconColor,
                  icon1InitialValue: icon1InitialValue,
                  icon2InitialValue: icon2InitialValue,
                  knobDecoration: knobDecoration,
                  setDurationCallback: setDurationCallback,
                ),
                Padding(
                  padding: EdgeInsets.all(diameter * gapRatio),
                  child: Center(
                    child: Clock(
                      radius: diameter * clockRatio,
                      clockDecoration: clockDecoration,
                      clockTextStyle: clockTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            decoration: knobBackgroundDecoration != null
                ? knobBackgroundDecoration!.copyWith(
                    shape: BoxShape.circle,
                  )
                : const BoxDecoration(
                    shape: BoxShape.circle,
                  ));
      }
      throw Exception(
          "Max allowed size is ${constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight}");
    });
  }
}
