import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlitetodo/firebase_options.dart';
import 'package:sqlitetodo/helper/notification.dart';
import 'package:sqlitetodo/pages/auth/sign_in.dart';
import 'package:sqlitetodo/pages/home/home_todo.dart';
import 'package:sqlitetodo/pages/navigator/nav.dart';
import 'package:sqlitetodo/pages/splash/splash_screen.dart';
import 'package:sqlitetodo/view_model/check_token_vm.dart';
import 'package:sqlitetodo/view_model/dblite_vm.dart';
import 'package:sqlitetodo/view_model/profile_random_vm.dart';
import 'package:sqlitetodo/view_model/profile_vm.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqlitetodo/view_model/todo_vm.dart';
import 'package:sqlitetodo/view_model/user_loginvm.dart';

Future<void> main() async {
  // Call WidgetsFlutterBinding : EnsureInitialized
  WidgetsFlutterBinding.ensureInitialized();

  // Call Config Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(
          message.notification!.title!, message.notification!.body!);
      print('Got a message whilst in the foreground!');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  FirebaseMessaging.onBackgroundMessage((message) async {
    print('Got a message whilst in the background!');
    NotificationService().showNotification(
        message.notification!.title!, message.notification!.body!);
  });

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseLiteViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileRandomViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CheckTokenViewModel()),
        ChangeNotifierProvider(create: (_) => TodoViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        home: SplashScreen(),
      )));
}
