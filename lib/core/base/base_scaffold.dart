import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app/styles.dart';

class BaseScaffold extends StatelessWidget {
  final bool isLoggedIn;
  final String title;
  final Widget child;
  final bool isBackEnabled;
  const BaseScaffold(
      {super.key,
      this.isLoggedIn = false,
      required this.title,
      required this.child,
      this.isBackEnabled = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              color: Styles.colors.kPrimaryColor,
              child: Padding(
                  padding: EdgeInsets.only(top: 8.h, right: 8.w),
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
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Logout',
                            style: Styles.textStyles.f16SemiBold
                                ?.copyWith(color: Colors.white),
                          ),
                        )
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 0.90.sh,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r))),
                child:
                    Scaffold(backgroundColor: Colors.transparent, body: child),
              ),
            ),
            Positioned(
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
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.blue),
                    child: Text(
                      title,
                      style: Styles.textStyles.f16SemiBold
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
