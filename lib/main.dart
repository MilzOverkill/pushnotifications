import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notifications/api/firebase_api.dart';
import 'package:push_notifications/firebase_options.dart';
import 'package:push_notifications/pages/home_page.dart';
import 'package:push_notifications/pages/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>(); // help us navigate between screens easily


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        navigatorKey: navigatorKey,
        routes: {
          '/notification_screen': (context) => const NotificationPage(),
        });
  }
}
