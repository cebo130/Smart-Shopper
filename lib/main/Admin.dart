import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_shopper/main/login_widget.dart';

import 'MyOrders.dart';
import 'addnote.dart';
import 'editnote.dart';
import 'main.dart';

class Admin extends StatefulWidget {
  //const MyOrders({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

final user = FirebaseAuth.instance.currentUser!;


class _AdminState extends State<Admin> {

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('cebo@gmail.com').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => addnote()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.orange,
          size: 30,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'All Orders',
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      drawer: NavigationDrawer(),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            editnote(docid: snapshot.data!.docs[index]),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.orange,
                            ),
                          ),
                          title: Text(
                            '${snapshot.data!.docChanges[index].doc['doc_id']}\n${snapshot.data!.docChanges[index].doc['title']}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.orange
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docChanges[index].doc['content'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}