import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static const _uuid = Uuid();

  static Future<String> uploadImage(File file) async {
    final reference =
        Get.find<FirebaseStorage>().ref().child("qrImages/${_uuid.v1()}");
    final uploadTask = reference.putFile(file);
    final taskSnapshot = await uploadTask.whenComplete(() {});
    return await taskSnapshot.ref.getDownloadURL();
  }
}
