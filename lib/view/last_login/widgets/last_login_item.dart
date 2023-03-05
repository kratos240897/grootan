import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app/styles.dart';
import '../../../core/data/models/login_details.dart';

class LastLoginItem extends StatelessWidget {
  final LoginDetails login;
  const LastLoginItem({
    super.key,
    required this.login,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            10.h.verticalSpace,
            SizedBox(
              height: 90.h,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                color: Styles.colors.kCardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(16.spMin),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getFormattedDate(login.loginTime),
                            style: Styles.textStyles.f12Regular
                                ?.copyWith(color: Colors.white),
                          ),
                          4.verticalSpace,
                          Text(
                            login.ipAddress,
                            style: Styles.textStyles.f12Regular
                                ?.copyWith(color: Colors.white),
                          ),
                          4.verticalSpace,
                          Text(
                            login.location,
                            style: Styles.textStyles.f12Regular
                                ?.copyWith(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (login.qrImage.isNotEmpty)
          Positioned(
            top: 0,
            right: 0,
            bottom: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                login.qrImage,
                height: 80.h,
                width: 90.h,
              ),
            ),
          )
      ],
    );
  }

  getFormattedDate(String date) {
    final dateTimeObj = DateTime.parse(date);
    return DateFormat('h:mm a').format(dateTimeObj);
  }
}
