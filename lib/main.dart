import 'package:alues_shrimp_app/pages/home_page_navbar.dart';
import 'package:alues_shrimp_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await loadFonts();
  bool isLoggedIn = await checkLoginStatus();

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

Future<bool> checkLoginStatus() async {
  // hanya butuh sekali login
  // User? user = FirebaseAuth.instance.currentUser;
  return false;
}

class MyApp extends StatelessWidget {
  var isLoggedIn;

  MyApp({
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        home: HomePageNavBar(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Inter'),
        home: LoginPage(),
      );
    }
  }
}

Future<void> loadFonts() async {
  await Future.wait([
    FontLoader('Inter-Regular').load(),
    FontLoader('Inter-Bold').load(),
    FontLoader('Inter-SemiBold').load(),
    FontLoader('Inter-Medium').load(),
    FontLoader('paladins').load(),
    FontLoader('ComicNeue-Regular').load(),
    FontLoader('ComicNeue-Bold').load(),
  ]);
}
