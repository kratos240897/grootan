import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/constants/app/styles.dart';
import 'core/init/routes/router.dart';
import 'core/init/routes/routes.dart';
import 'core/repo/app_repo.dart';
import 'core/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await inject();
  runApp(const MyApp());
}

Future<void> inject() async {
  Get.lazyPut(() => FirebaseAuth.instance, fenix: true);
  Get.lazyPut(() => AuthService(), fenix: true);
  Get.lazyPut(() => FirebaseStorage.instance, fenix: true);
  Get.lazyPut(() => FirebaseFirestore.instance, fenix: true);
  Get.lazyPut(() => AppRepo(), fenix: true);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = Get.find<AuthService>();
  var _isLoggedIn = false;

  @override
  void initState() {
    if (_authService.getUser() != null) {
      _isLoggedIn = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grootan',
            theme: ThemeData(
              primarySwatch: Styles.colors.kPrimaryColor,
            ),
            initialRoute: _isLoggedIn ? Routes.PLUGIN : Routes.LOGIN,
            onGenerateRoute: PageRouter.generateRoutes,
          );
        });
  }
}
