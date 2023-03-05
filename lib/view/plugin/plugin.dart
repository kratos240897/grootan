import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grootan/view/plugin/plugin_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/base/base_scaffold.dart';
import '../../core/components/custom_button.dart';
import '../../core/constants/app/styles.dart';
import '../../core/init/routes/routes.dart';

class Plugin extends GetView<PluginController> {
  Plugin({super.key});

  final GlobalKey _qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isLoggedIn: true,
      title: 'PLUGIN',
      child: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0.06.sh, 22.w, 16.h),
        child: Obx(() {
          return Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: RepaintBoundary(
                      key: _qrKey,
                      child: Container(
                        color: Colors.white,
                        child: QrImage(
                          data: controller.randomNumber.value.toString(),
                          size: 0.2.sh,
                        ),
                      ),
                    )),
              ),
              16.verticalSpace,
              Text(
                'Generated Number',
                style:
                    Styles.textStyles.f18Regular?.copyWith(color: Colors.white),
              ),
              16.verticalSpace,
              Text(
                controller.randomNumber.toString(),
                style: Styles.textStyles.f18Bold?.copyWith(color: Colors.white),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.LAST_LOGIN),
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white)),
                  child: Text(
                    'Last login ${controller.lastLoginTime}',
                    style: Styles.textStyles.f14Regular
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              16.verticalSpace,
              CustomButton(
                  label: 'SAVE',
                  onPressed: () async {
                    await controller.saveQR(_qrKey);
                  },
                  color: Styles.colors.kButtonColor)
            ],
          );
        }),
      ),
    );
  }
}
