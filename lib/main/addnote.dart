import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:smart_shopper/main/editnote.dart';
import 'Admin.dart';
import 'MyOrders.dart';
import 'database.dart';
import 'main.dart';

class addnote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  //final user = FirebaseAuth.instance.currentUser!;
  final List<String> itemSizes = [
    'small',
    'Large',
  ];
  String? isSelected;
  final _formKey = GlobalKey<FormState>();
  bool cebo = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference ref = FirebaseFirestore.instance.collection('Aorders');//create new record
    //start
    var collection = FirebaseFirestore.instance.collection('Aorders');
    collection.doc(user.uid); // <-- Document ID
        //.set({'age': 20}) // <-- Your data
        //.then((_) => print('Added'))
        //.catchError((error) => print('Add failed: $error'));
    // end
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(user.email == 'ok@gmail.com'){
            return Admin();//MainPage();//MyOrders();
          }else{
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Add Items',
                  style: TextStyle(color: Colors.orange),
                ),
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.orange),

              ),
              drawer: NavigationDrawer(),
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height:40),
                      Row(
                        children: [

                          SizedBox(width:131),
                          Image.asset('assets/images/cebo2.png',scale: 6,),

                          SizedBox(width: 17),

                        ],
                      ),
                      Form(

                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  //Add isDense true and zero Padding.
                                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  //Add more decoration as you want here
                                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Size of items ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.orangeAccent,
                                ),/*Icon*/
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),/*BpxDecoration*/
                                items: itemSizes
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),/*TextStyle*/
                                      ),
                                    ))/*DropdownMenuItem*/
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select size of items.';
                                  }else{
                                    cebo=true;
                                  }
                                },
                                onChanged: (value) {
                                  cebo=true;
                                  //Do something when changing the item if you want.
                                },
                                onSaved: (value) {
                                  isSelected = value.toString();
                                },
                              ),/*DropDownFormField2*/
                              const SizedBox(height: 30),
                              //here
                              const SizedBox(height: 1),
                              Container(//return expanded
                                width: 350,
                                height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orangeAccent,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                                child: TextField(
                                  controller: content,
                                  expands: true,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'write all items here...',
                                  ),
                                ),
                              ),
                              SizedBox(height:50),
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                },
                                child: Container(

                                  height:50,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                      }
                                      if(cebo==true){
                                        await DatabaseService(uid: user.uid).updateUseData(isSelected!, content.text).whenComplete(() {
                                          if(title!='' && content !=''){
                                            Navigator.pushReplacement(
                                                context, MaterialPageRoute(builder: (_) => MyOrders()));//Fix this error here on line 97 ///////////
                                          }

                                        });
                                      }

                                    },
                                    child: Text("Next",style:TextStyle(color:Colors.orange,fontSize: 22),),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.white),
                                          ),/*RoundedRectangularBorder*/
                                        )
                                    ),/*ButtonStyle*/

                                  ),/*ElevatedButton*/
                                ),/*Container*/
                              ),/*TextButton*/
                            ],
                          ),/*Column*/
                        ),/*Padding*/
                      ),/*Form*/
                      SizedBox(height:20),
                      /* Container(
                width: 350,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'large or small Items...',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(//return expanded
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: TextField(
                  controller: content,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'write all items here...',
                  ),
                ),
              ),
              SizedBox(height:50),
              Container(
                height:50,
                width: 160,
                //color: Colors.orange,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  color: Colors.white,
                  onPressed: () {
                    ref.add({
                      'title': title.text,
                      'content': content.text,
                    }).whenComplete(() {
                      if(title!='' && content !=''){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => MyOrders()));//Fix this error here on line 97 ///////////
                      }

                    });
                  },
                  child: Text(
                    "save",
                    style: TextStyle(color: Colors.orange,fontSize: 19),
                  ),
                ),
              ),*/
                      SizedBox(height:20),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}