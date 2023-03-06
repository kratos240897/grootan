import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/app/styles.dart';
import '../../constants/enum/device_type.dart';
import '../../constants/enum/snack_bar_status.dart';
import '../../data/models/login_details.dart';

class Utils {
  Utils._();
  static Utils? _instance;
  factory Utils() {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = Utils._();
      return _instance!;
    }
  }
  final context = Get.context!;
  showSnackBar(String title, String message, SnackBarStatus status) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: Styles.colors.kButtonColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15.w),
        content: SizedBox(
          height: 0.06.sh,
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  color: status == SnackBarStatus.success
                      ? Colors.green
                      : status == SnackBarStatus.failure
                          ? Colors.red
                          : Colors.blue,
                  borderRadius: BorderRadius.circular(5.r)),
              width: 0.02.sw,
            ),
            0.05.sw.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      Styles.textStyles.f14Bold?.copyWith(color: Colors.white),
                ),
                4.verticalSpace,
                Expanded(
                  child: Text(message,
                      style: Styles.textStyles.f14Bold
                          ?.copyWith(color: Colors.white)),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ]),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              backgroundColor: Styles.colors.kButtonColor,
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return SizedBox(
                    height: Get.height * 0.25,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Loading...',
                              style: Styles.textStyles.f18Bold
                                  ?.copyWith(color: Colors.white)),
                          12.verticalSpace,
                          const CupertinoActivityIndicator(
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
  }

  hideLoading() {
    Navigator.pop(context);
  }

  static List<LoginDetails> sortListDateandTimeWise(List<LoginDetails> loginList) {
    loginList.sort((a, b) {
      var aDate = DateTime.parse(a.loginTime);
      var bDate = DateTime.parse(b.loginTime);
      return aDate.compareTo(bDate);
    });
    loginList = List.from(loginList.reversed);
    return loginList;
  }

  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? DeviceType.phone : DeviceType.tablet;
  }
}
