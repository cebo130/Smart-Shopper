import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:smart_shopper/main/database.dart';
import 'package:smart_shopper/main/utils.dart';
import 'main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedLogIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedLogIn,
  }) : super(key: key);
  //const LoginWidget({Key? key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final user = FirebaseAuth.instance.currentUser!;
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(

    padding: EdgeInsets.all(16),
    child: Form(
      key: formKey,
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
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Enter Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))

                ),
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                /*validator: (email) =>
                email != null && !EmailValidator.validate(email)
                ? 'Enter a valid email mfe2!'
                : null,*/
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 260,

              child: TextFormField(
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: "Enter password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))
                ),
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                /*validator: (value) =>
                value != null && value.length < 6
                    ? 'Enter min of 6 characters mfe2 hau!'
                    : null,*/
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
                  'SignUp',
                  style:TextStyle(fontSize: 24,color: Colors.orange),
                ),
                onPressed: signUp,
              ),
            ),
            SizedBox(height:24),
            RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.grey,fontSize: 20,
                  ),
                  text: 'already have an account? ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedLogIn,
                      text: 'LogIn',//alternative
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
    ),
  );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: SpinKitSpinningLines(
          color: Colors.orange,
          size: 150.0,
        ),
      ),
    );
    UserCredential authResult;
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      var user = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("new_year").doc("$user").set(
        {
          "email" : emailController.text,
          "password" : passwordController.text,
        }
      );
      //await DatabaseService(uid: user.uid).updateUseData('large', 'inkomishi');
    }on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
