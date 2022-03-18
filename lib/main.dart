import 'package:firebase_core/firebase_core.dart';
import 'package:firepost/Pages/Detail_Page.dart';
import 'package:firepost/Pages/HomePage.dart';
import 'package:firepost/Pages/SignInPage.dart';
import 'package:firepost/Pages/SignUpPage.dart';

import 'package:firepost/Services/hive_db.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

      // options: DefaultFirebaseOptions.currentPlatform,
      );
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fire Post",
      home: SignUpPage(),
      routes: {
        HomePage.id:(context)=>HomePage(),
        SignUpPage.id: (context) => SignUpPage(),
        SignInPage.id: (context) => SignInPage(),
        DetailPage.id: (context) => DetailPage(),

      },
    );
  }
}
