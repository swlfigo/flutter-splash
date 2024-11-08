import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:splash/component/utils/colors_ext.dart';

class ComponentSegmentControl extends StatelessWidget {
  final Function(int value) onChange;
  final int initialIndex;
  final Map<int, Widget> segmentTitle;
  const ComponentSegmentControl(
      {super.key,
      required this.onChange,
      required this.initialIndex,
      required this.segmentTitle});

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl(
      children: segmentTitle,
      thumbDecoration: BoxDecoration(
        color: HexColor("636368"),
        borderRadius: BorderRadius.circular(6),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: HexColor("29292c"),
      ),
      initialValue: initialIndex,
      onValueChanged: (index) {
        onChange(index);
      },
    );
  }
}
