import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/data/models/login_details.dart';
import '../last_login_controller.dart';
import 'last_login_item.dart';

class LastLoginList extends StatefulWidget {
  final int selectedIndex;
  final LastLoginController controller;
  const LastLoginList({
    super.key,
    required this.controller,
    required this.selectedIndex,
  });

  @override
  State<LastLoginList> createState() => _LastLoginListState();
}

class _LastLoginListState extends State<LastLoginList>
    with AutomaticKeepAliveClientMixin {
  late List<LoginDetails> logins;

  @override
  void initState() {
    if (widget.selectedIndex == 0) {
      logins = widget.controller.todayLoginList;
    } else if (widget.selectedIndex == 1) {
      logins = widget.controller.yesterdayLoginList;
    } else {
      logins = widget.controller.otherLoginList;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return ListView.builder(
        padding: EdgeInsets.only(top: 8.h),
        itemCount: logins.length,
        itemBuilder: (context, index) {
          return LastLoginItem(login: logins[index]);
        },
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
