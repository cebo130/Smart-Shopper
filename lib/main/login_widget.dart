import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'main.dart';
class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
}) : super(key: key);
  //const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(

    padding: EdgeInsets.all(16),
    child: Container(
      padding: EdgeInsets.only(left: 40.0,top: 00,right: 00,bottom: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Image.asset('assets/images/cebo.png',scale: 4,),

          Text(
              'Smart-Shopper',
            style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize:30),
          ),
          SizedBox(height: 40),
          Container(
            width: 260,
            child: TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Enter Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))

              ),

            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 260,

            child: TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: "Enter password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 200,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                 primary: Colors.white,
              ),
              icon: Icon(Icons.lock_open, size: 32,color: Colors.orange,),
              label: Text(
                'LogIn',
                style:TextStyle(fontSize: 24,color: Colors.orange),
              ),
              onPressed: signIn,
            ),
          ),
          SizedBox(height:24),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey,fontSize: 20,
              ),
              text: 'No account? ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,//here-------
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    ),
  );
  Future signIn() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 150.0,
        ),
      ),
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch(e){
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
