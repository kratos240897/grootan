import 'package:get/get.dart';
import '../../core/data/models/login_details.dart';
import '../../core/init/utils/utils.dart';
import '../../core/repo/app_repo.dart';

class LastLoginController extends GetxController {
  final _repo = Get.find<AppRepo>();
  RxList<LoginDetails> todayLoginList = RxList.empty();
  RxList<LoginDetails> yesterdayLoginList = RxList.empty();
  RxList<LoginDetails> otherLoginList = RxList.empty();

  Future<void> retrieveLoginDetails() async {
    Utils().showLoading();
    _repo.getAllLogins().then((logins) {
      for (var login in logins) {
        if (calculateDifference(DateTime.parse(login.loginTime)) == 0) {
          todayLoginList.add(login);
        } else if (calculateDifference(DateTime.parse(login.loginTime)) == -1) {
          yesterdayLoginList.add(login);
        } else {
          otherLoginList.add(login);
        }
      }

      todayLoginList.value = Utils.sortListDateandTimeWise(todayLoginList);
      yesterdayLoginList.value =
          Utils.sortListDateandTimeWise(yesterdayLoginList);
      otherLoginList.value = Utils.sortListDateandTimeWise(otherLoginList);

      Utils().hideLoading();
    });
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
