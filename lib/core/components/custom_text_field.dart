import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app/styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?) validatorCallback;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      required this.inputType,
      required this.validatorCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.textStyles.f14SemiBold?.copyWith(color: Colors.white),
        ),
        12.verticalSpace,
        Stack(
          children: [
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                  color: Styles.colors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: inputType,
                controller: controller,
                validator: validatorCallback,
                style:
                    Styles.textStyles.f16Regular?.copyWith(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: Styles.textStyles.f12Regular
                        ?.copyWith(color: Colors.red)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
