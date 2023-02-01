import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_shopper/main/MyOrders.dart';
import 'package:smart_shopper/main/addnote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopper/main/signup.dart';
import 'package:smart_shopper/main/utils.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../angry/create.dart';
import '../angry/order_page.dart';
import 'LocationPage.dart';
import 'addnote.dart';
import 'authpage.dart';
import 'editnote.dart';
import 'login_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    scaffoldMessengerKey: Utils.messengerKey,
    navigatorKey: navigatorKey,
    title: "Smart - Shopper",
    home: AnimatedSplashScreen(
      splash: Image.asset(
        'assets/images/loco.png',
      ),
      splashIconSize: 100,
      nextScreen: MainPage(),
      splashTransition: SplashTransition.scaleTransition,

      //backgroundColor: Colors.orange,
    ),
  );
}
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: SpinKitSpinningLines(
              color: Colors.orange,
              size: 150.0,
            ),
          );
        }else if(snapshot.hasError){
          return Center(
            child: Text('U offline baba, vula i Data Zikhale !'),
          );
        }else if(snapshot.hasData){
          return OrderPage();

        }else{
          return AuthPage();
        }
      },
    ),
  );
}