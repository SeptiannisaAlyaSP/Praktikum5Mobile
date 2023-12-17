import 'package:ICE_CREAM_APP/firebase_options.dart';
import 'package:ICE_CREAM_APP/models/cart.dart';
import 'package:ICE_CREAM_APP/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'controller/notif_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingHandler().initPushNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => GetMaterialApp(
        // debugShowCheckedModeBanner: false,
        home: RegisterPage(),
      ),
    );
  }
}
