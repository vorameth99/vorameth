import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart'; // น าเข้าไฟล์ที่ต้องการเรียกใช้จากหน้า 'auth.dart'
import 'signin_page.dart'; // น าเข้าไฟล์ที่ต้องการเรียกใช้จากหน้า 'signin_page.dart'
import 'home_page.dart'; // น าเข้าไฟล์ที่ต้องการเรียกใช้จากหน้า 'homepage_page.dart'
import 'profilesetup.dart';
//Method หลักทีRun
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDK_N-B6MtSHsWcVOK9iI0toeBEL4-FjtA",
            authDomain: "fir-connect-2f379.firebaseapp.com",
            databaseURL: "https://fir-connect-2f379.firebaseio.com",
            projectId: "fir-connect-2f379",
            storageBucket: "fir-connect-2f379.appspot.com",
            messagingSenderId: "691283631304",
            appId: "1:691283631304:web:c4ec86210a96342819d9fd"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

// Class MyApp ส าหรับการแสดงผลหน้าจอ
class MyApp extends StatelessWidget {
  MyApp({super.key});
// ตรวจสอบ AuthService
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      home: StreamBuilder(
        stream: _auth.authStateChanges, // ตรวจสอบการเชื่อมต่อ Stream
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return HomePage(); // ตรวจสอบว่ามี HomePage และท างานได้
          } else {
            return const LoginPage(); // ตรวจสอบว่ามี LoginPage และท างานได้
          }
        },
      ),
      routes: {
        LoginPage.routeName: (BuildContext context) => const LoginPage(),
        HomePage.routeName: (BuildContext context) => HomePage(),
        Profilesetup.routeName: (BuildContext context) => Profilesetup(),
      },
    );
  }
}
