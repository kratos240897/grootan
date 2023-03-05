import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app/styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final GestureTapCallback? onPressed;
  final Color color;
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: Styles.colors.kCardColor,
      height: 40.h,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: color,
      onPressed: onPressed,
      child: Text(
        label,
        style: Styles.textStyles.f16SemiBold?.copyWith(color: Colors.white),
      ),
    );
  }
}
