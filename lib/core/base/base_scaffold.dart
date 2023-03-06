import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grootan/core/constants/enum/snack_bar_status.dart';
import 'package:grootan/core/init/routes/routes.dart';
import 'package:grootan/core/init/utils/utils.dart';
import 'package:grootan/core/service/auth_service.dart';

import '../constants/app/styles.dart';

class BaseScaffold extends StatelessWidget {
  final bool isLoggedIn;
  final String title;
  final Widget child;
  final bool isBackEnabled;
  final bool isBackgroundImageVisible;
  BaseScaffold(
      {super.key,
      this.isLoggedIn = false,
      this.isBackgroundImageVisible = false,
      required this.title,
      required this.child,
      this.isBackEnabled = false});

  final _authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _scaffoldBackgroundLayerWithActions(),
            _scaffoldBackgroundImageLayer(),
            _scaffoldChildLayer(),
            _scaffoldTitleLayer(),
          ],
        ),
      ),
    );
  }

  Positioned _scaffoldTitleLayer() {
    return Positioned(
      top: 0.05.sh,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 35.h,
            padding: EdgeInsets.symmetric(horizontal: 16.spMin),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r), color: Colors.blue),
            child: Text(
              title,
              style:
                  Styles.textStyles.f16SemiBold?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Align _scaffoldChildLayer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0.90.sh,
        decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r))),
        child: Scaffold(backgroundColor: Colors.transparent, body: child),
      ),
    );
  }

  Align _scaffoldBackgroundImageLayer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r))),
          height: 0.90.sh,
          padding: EdgeInsets.only(top: 0.2.sh),
          alignment: Alignment.topCenter,
          child: isBackgroundImageVisible
              ? FittedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SvgPicture.asset(
                      'lib/assets/rectangle.svg',
                      fit: BoxFit.fill,
                      height: 0.2.sh,
                    ),
                  ),
                )
              : null),
    );
  }

  Container _scaffoldBackgroundLayerWithActions() {
    return Container(
      alignment: Alignment.topCenter,
      color: Styles.colors.kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isBackEnabled
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                  ))
              : const Spacer(),
          if (isLoggedIn)
            Padding(
              padding: EdgeInsets.only(top: 4.h, right: 6.w),
              child: TextButton(
                onPressed: () async {
                  Utils().showLoading();
                  final result = await _authService.signOut();
                  Utils().hideLoading();
                  if (result) {
                    Get.offAllNamed(Routes.LOGIN);
                  } else {
                    Utils().showSnackBar('Failed', 'Something went wrong ',
                        SnackBarStatus.failure);
                  }
                },
                child: Text(
                  'Logout',
                  style: Styles.textStyles.f16SemiBold
                      ?.copyWith(color: Colors.white),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class RoundedRectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Styles.colors.kPrimaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.7000000, size.height * 0.2000000);
    path0.lineTo(size.width * 0.3000000, size.height * 0.2000000);
    path0.lineTo(size.width * 0.6980000, size.height * 0.5960000);
    path0.quadraticBezierTo(size.width * 0.6985000, size.height * 0.4970000,
        size.width * 0.7000000, size.height * 0.2000000);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = Styles.colors.kCardColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path1 = Path();
    path1.moveTo(size.width * 0.3000000, size.height * 0.1960000);
    path1.lineTo(size.width * 0.2980000, size.height * 0.6000000);
    path1.lineTo(size.width * 0.6980000, size.height * 0.6000000);
    path1.lineTo(size.width * 0.3000000, size.height * 0.1960000);
    path1.close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
