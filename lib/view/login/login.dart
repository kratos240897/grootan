import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/base/base_scaffold.dart';
import '../../core/components/custom_button.dart';
import '../../core/components/custom_text_field.dart';
import '../../core/constants/app/styles.dart';
import 'login_controller.dart';

class Login extends GetView<LoginController> {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isLoggedIn: false,
      title: 'Login',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.spMin),
        child: Form(
            key: _formKey,
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    inputType: TextInputType.phone,
                    label: 'Phone Number',
                    controller: _phoneNumberController,
                    validatorCallback: (value) {
                      if (value!.length < 10) {
                        return 'Mobile number cannot be lesser than 10 digits';
                      } else if (value.length > 10) {
                        return 'Mobile number cannot be greater than 10 digits';
                      } else {
                        return null;
                      }
                    },
                  ),
                  if (controller.isPhoneNumberVerified.value)
                    Column(
                      children: [
                        16.verticalSpace,
                        CustomTextField(
                          inputType: TextInputType.number,
                          label: 'OTP',
                          controller: _otpController,
                          validatorCallback: (value) {
                            if (value!.length < 6 || value.length > 6) {
                              return 'Invalid OTP';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  32.verticalSpace,
                  CustomButton(
                    label: 'LOGIN',
                    onPressed: () async {
                      final isFormValid = _formKey.currentState?.validate();
                      if (isFormValid!) {
                        if (controller.isPhoneNumberVerified.isTrue) {
                          await controller
                              .verifyOTP(_otpController.text.trim());
                        } else {
                          await controller.verifyPhoneNumber(
                              _phoneNumberController.text.trim());
                        }
                      }
                    },
                    color: Styles.colors.kButtonColor,
                  )
                ],
              );
            })),
      ),
    );
  }
}
