import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';

import '../../core/base/base_scaffold.dart';
import '../../core/constants/app/styles.dart';
import 'last_login_controller.dart';
import 'widgets/last_login_list.dart';


class LastLogin extends StatefulWidget {
  const LastLogin({super.key});

  @override
  State<LastLogin> createState() => _LastLoginState();
}

class _LastLoginState extends State<LastLogin>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final LastLoginController _controller = Get.find<LastLoginController>();
  late List<Map<String, dynamic>> _tabs;

  @override
  void initState() {
    _tabs = [
      {
        'title': 'Today',
        'view': LastLoginList(selectedIndex: 0, controller: _controller)
      },
      {
        'title': 'Yesterday',
        'view': LastLoginList(selectedIndex: 1, controller: _controller)
      },
      {
        'title': 'Other',
        'view': LastLoginList(selectedIndex: 2, controller: _controller)
      }
    ];
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.retrieveLoginDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isBackEnabled: true,
      isLoggedIn: true,
      title: "LAST LOGIN",
      child: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 0.06.sh, 22.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
                isScrollable: true,
                controller: _tabController,
                indicatorColor: Colors.white,
                labelStyle: Styles.textStyles.f12SemiBold
                    ?.copyWith(color: Colors.white),
                unselectedLabelStyle: Styles.textStyles.f12SemiBold
                    ?.copyWith(color: Colors.grey.shade900),
                tabs: _tabs
                    .map((e) => Tab(
                          text: (e['title'] as String).toUpperCase(),
                        ))
                    .toList()),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: _tabs.map((e) => e['view'] as Widget).toList(),
            )),
          ],
        ),
      ),
    );
  }
}
