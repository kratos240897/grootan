import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = Get.find<FirebaseAuth>();
  var _verificationId = '';
  VoidCallback? verificationCompletedCallback;
  Function(String)? verificationFailedCallback;
  VoidCallback? codeSentCallback;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required VoidCallback verificationCompletedCallback,
    required Function(String) verificationFailedCallback,
    required VoidCallback codeSentCallback,
  }) async {
    this.verificationCompletedCallback = verificationCompletedCallback;
    this.verificationFailedCallback = verificationFailedCallback;
    this.codeSentCallback = codeSentCallback;
    _auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  Future<void> verifyOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp);
    await _auth.signInWithCredential(credential);
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    verificationCompletedCallback?.call();
    await _auth.signInWithCredential(credential);
  }

  void _verificationFailed(FirebaseAuthException e) {
    verificationFailedCallback?.call(e.code);
  }

  void _codeSent(String verificationId, int? resendToken) async {
    codeSentCallback?.call();
    _verificationId = verificationId;
  }

  void _codeAutoRetrievalTimeout(String verificationId) {}

  User? getUser() {
    try {
      return _auth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    } on Exception {
      return false;
    }
  }
}
