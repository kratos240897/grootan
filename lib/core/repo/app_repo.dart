import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/instance_manager.dart';
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
    final docs = await getAllLogins();
    return docs.first;
  }

  Future<LoginDetails> getLasttLogin() async {
    final docs = await getAllLogins()
      ..sort((a, b) {
        var aDate = DateTime.parse(a.loginTime);
        var bDate = DateTime.parse(b.loginTime);
        return aDate.compareTo(bDate);
      });
    return docs[docs.length - 2];
  }

  Future<bool> updateQR(String imageUrl) async {
    final doc = await getCurrentLogin();
    if (doc.qrImage.isEmpty) {
      await _loginDetailsCollection.doc(doc.id).update({'qr_image': imageUrl});
      return true;
    } else {
      return false;
    }
  }
}
