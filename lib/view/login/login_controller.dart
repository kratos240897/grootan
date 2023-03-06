import 'package:get/get.dart';
import '../../core/constants/enum/snack_bar_status.dart';
import '../../core/init/routes/routes.dart';
import '../../core/init/utils/utils.dart';
import '../../core/service/auth_service.dart';


class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  RxBool isPhoneNumberVerified = false.obs;

  Future<void> verifyPhoneNumber(String phone) async {
    Utils().showLoading();
    await _authService.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompletedCallback: () {},
      verificationFailedCallback: (error) {
        Utils().hideLoading();
        isPhoneNumberVerified.value = false;
        if (error == 'invalid-phone-number') {
          Utils().showSnackBar(
              'Failed', 'Invalid phone number', SnackBarStatus.failure);
        } else {
          Utils().showSnackBar(
              'Failed', 'Something went wrong', SnackBarStatus.failure);
        }
      },
      codeSentCallback: () {
        Utils().hideLoading();
        isPhoneNumberVerified.value = true;
      },
    );
  }

  Future<void> verifyOTP(String smsCode) async {
    Utils().showLoading();
    _authService.verifyOTP(smsCode).then((value) {
      Utils().hideLoading();
      Get.offNamed(Routes.PLUGIN);
    }).onError((error, stackTrace) {
      Utils().hideLoading();
      Utils().showSnackBar(
          'Failed', 'Invalid OTP', SnackBarStatus.failure);
    });
  }
}
