import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/instance_manager.dart';
import 'package:grootan/core/init/utils/utils.dart';
import 'package:uuid/uuid.dart';
import '../data/models/login_details.dart';

class AppRepo {
  static final FirebaseFirestore _firestore = Get.find<FirebaseFirestore>();
  final _loginDetailsCollection = _firestore.collection('login_details');

  Future<void> addLoginDetails(LoginDetails loginDetails) async {
    final uuid = const Uuid().v1();
    loginDetails.id = uuid;
    await _loginDetailsCollection.doc(uuid).set(loginDetails.toJson());
  }

  Future<List<LoginDetails>> getAllLogins() async {
    final querySnapshot = await _loginDetailsCollection.get();
    return querySnapshot.docs
        .map((doc) => LoginDetails.fromJson(doc.data()))
        .toList();
  }

  Future<LoginDetails> getCurrentLogin() async {
    var logins = await getAllLogins();
    logins = Utils.sortListDateandTimeWise(logins);
    return logins[0];
  }

  Future<LoginDetails> getLasttLogin() async {
    var logins = await getAllLogins();
    logins = Utils.sortListDateandTimeWise(logins);
    return logins[1];
  }

  Future<bool> updateQR(String imageUrl) async {
    final login = await getCurrentLogin();
    if (login.qrImage.isEmpty) {
      await _loginDetailsCollection.doc(login.id).update({'qr_image': imageUrl});
      return true;
    } else {
      return false;
    }
  }
}
