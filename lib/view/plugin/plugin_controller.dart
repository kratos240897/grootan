import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants/enum/snack_bar_status.dart';
import '../../core/data/models/login_details.dart';
import '../../core/init/utils/utils.dart';
import '../../core/repo/app_repo.dart';
import '../../core/service/storage_service.dart';
import 'dart:ui' as ui;

class PluginController extends GetxController {
  final randomNumber = 0.obs;
  final lastLoginTime = ''.obs;
  late String ipAddress;
  late String location;
  DateTime loginDateTimeObj = DateTime.now();
  final _repo = Get.find<AppRepo>();

  @override
  void onReady() async {
    randomNumber.value = _getInteger(5);
    Utils().showLoading();
    await _getCurrentPosition();
    await _getIpAddress();
    await _getlastLoginTime();
    await _storeLoginDetails();
    Utils().hideLoading();
    super.onReady();
  }

  int _getInteger(int digitCount) {
    final random = Random();
    var digit = random.nextInt(9) + 1;
    int n = digit;
    for (var i = 0; i < digitCount - 1; i++) {
      digit = random.nextInt(10);
      n *= 10;
      n += digit;
    }
    return n;
  }

  Future<void> _storeLoginDetails() async {
    final loginDetails = LoginDetails(
        id: '',
        location: location,
        ipAddress: ipAddress,
        qrImage: '',
        loginTime: loginDateTimeObj.toIso8601String());
    await _repo.addLoginDetails(loginDetails);
  }

  Future<void> _getlastLoginTime() async {
    final lastLogin = await _repo.getLasttLogin();
    final lastLoginDateTimeObj = DateTime.parse(lastLogin.loginTime);
    final date = DateFormat('EEE, MMM d').format(lastLoginDateTimeObj);
    final time = DateFormat('h:mm a').format(lastLoginDateTimeObj);
    lastLoginTime.value = '$date at $time';
  }

  Future<void> _getIpAddress() async {
    ipAddress = await Ipify.ipv4();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      await _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      location = place.locality ?? 'Unknown';
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils().showSnackBar(
          'Info',
          'Location services are disabled. Please enable the services',
          SnackBarStatus.info);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils().showSnackBar(
            'Info', 'Location permission denied', SnackBarStatus.info);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils().showSnackBar(
          'Info',
          'Location permissions are permanently denied, we cannot request permissions.',
          SnackBarStatus.info);
      return false;
    }
    return true;
  }

  Future<void> saveQR(GlobalKey key) async {
    Utils().showLoading();
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    Directory? tempDir = Directory('/storage/emulated/0/Download');
    if (!await tempDir.exists()) tempDir = await getExternalStorageDirectory();
    final file = await File('${tempDir?.path}/shareqr.png').create();
    await file.writeAsBytes(pngBytes);
    final downloadUrl = await StorageService.uploadImage(file);
    final result = await _repo.updateQR(downloadUrl);
    Utils().hideLoading();
    if (result) {
      Utils().showSnackBar('Success', 'QR updated', SnackBarStatus.success);
    } else {
      Utils()
          .showSnackBar('Failed', 'QR already updated', SnackBarStatus.failure);
    }
  }
}
