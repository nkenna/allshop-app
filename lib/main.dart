import 'dart:io';

import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/businessprovider.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/providers/plazaprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/providers/storeprovider.dart';
import 'package:ems/screens/auth/login_screen.dart';
import 'package:ems/utils/projectcolors.dart';
import 'package:ems/utils/sharedprefs.dart';
import 'package:ems/widgets/splash_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

final ThemeData kIOSTheme = ThemeData(
    primarySwatch: materialMainColor,
    primaryColor: mainColor,
    //primaryIconTheme: IconThemeData(color: Colors.white),
    //primaryColorBrightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'SofiaProRegular'

);

final ThemeData kDefaultTheme = ThemeData(
    primarySwatch: materialMainColor,
    primaryColor: mainColor,
    //primaryIconTheme: IconThemeData(color: Colors.white),
    //primaryColorBrightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'SofiaProRegular'
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

configureFPN() async{
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

   
  channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title // description
      importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel!);
 

  flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
  );

  /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance .getInitialMessage()
      .then((RemoteMessage? message) {
        print(message);

    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message)async {
    RemoteNotification notification = message!.notification!;
    AndroidNotification android = message.notification!.android!;   
    AppleNotification apple = message.notification!.apple!;

    print("MESSAGE IS COMING");


    if (notification != null && android != null) {
      AndroidNotificationDetails andWOImage = AndroidNotificationDetails(
          channel!.id,
          channel!.name,
          channelDescription: channel!.description,
          icon: 'ic_notif',
          enableLights: true,
          visibility: NotificationVisibility.public
      );

      flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,

          NotificationDetails(
            android: andWOImage,
          ));
    }

    if (notification != null && apple != null) {
      AndroidNotificationDetails andWOImage = AndroidNotificationDetails(
          channel!.id,
          channel!.name,
          channelDescription: channel!.description,
          icon: 'ic_notif',
          enableLights: true,
          visibility: NotificationVisibility.public
      );

      IOSNotificationDetails ios = IOSNotificationDetails(

      );

      flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,

          NotificationDetails(
            iOS: ios
          ));
    }
  });

  FirebaseMessaging.onBackgroundMessage((message) {
    print('A new background event!');
    print('${message.data}');

    return Future.value();
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print('${message.data}');

    return;
  });
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance.initializePreference();
  await configureFPN();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: mainColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: mainColor,
      )
  );
  

  runApp(
      MultiProvider(providers: [
       ChangeNotifierProvider(create: (context) => AuthProvider()),
       ChangeNotifierProvider(create: (context) => HomeProvider()),
       ChangeNotifierProvider(create: (context) => PlazaProvider()),
       ChangeNotifierProvider(create: (context) => StoreProvider()),
       ChangeNotifierProvider(create: (context) => ProductProvider()),
       ChangeNotifierProvider(create: (context) => BusinessProvider()),
      ],
        child: const MyApp(),
      )
  );
 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AllShop',
      theme: Platform.isIOS ? kIOSTheme : kDefaultTheme,
      home: SplashPage(), //const LoginScreen()
    );
  }
}

