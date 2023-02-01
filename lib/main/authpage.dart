import 'package:flutter/material.dart';
import 'package:smart_shopper/main/signup.dart';

import 'login_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? LoginWidget(onClickedSignUp: toggle)
          : SignUpWidget(onClickedLogIn: toggle);

  void toggle() =>
      setState(() {
        isLogin = !isLogin;
      });
}
