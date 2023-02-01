import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_shopper/main/login_widget.dart';

import 'addnote.dart';
import 'editnote.dart';
import 'main.dart';

class MyOrders extends StatefulWidget {
  //const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}
final user = FirebaseAuth.instance.currentUser!;
class _MyOrdersState extends State<MyOrders> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Aorders').snapshots();

  //final Stream<QuerySnapshot> _usersStream2 = FirebaseFirestore.instance.collection('Aorders').doc(id).snapshots();
  /*final docRef = db.collection("cities").doc("SF");
  docRef.get().then(
  (res) => print("Successfully completed"),
  onError: (e) => print("Error completing: $e"),
  );*/


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
          'Placed Orders',
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
                            snapshot.data!.docChanges[index].doc['title'],
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
class NavigationDrawer extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  //const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(

    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
  Widget buildHeader(BuildContext context) => Container(

    color: Colors.white,
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: NetworkImage(
            'https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295430_960_720.png',
            //scale: 1,
          ),
        ),
        SizedBox(height:20),
        Text(
            user.email!,
          style: TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(

    padding: EdgeInsets.all(24),
    child: Wrap(
      //runSpacing: 1,
      children: [
        Divider(color:Colors.orange),
        ListTile(
          leading: Icon(Icons.home_outlined,color: Colors.orange,size: 30,),
          title: Text('Home',style: TextStyle(color: Colors.orange,fontSize: 20),),
          onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => addnote())),
        ),
        Divider(color:Colors.orange),
        ListTile(
          leading: Icon(Icons.add_shopping_cart,color: Colors.orange,size: 30,),
          title: Text('Add Item',style: TextStyle(color: Colors.orange,fontSize: 20),),
          onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => addnote())),
        ),
        Divider(color:Colors.orange),
        ListTile(
          leading: Icon(Icons.shopping_cart_outlined,color: Colors.orange,size: 30,),
          title: Text('My Orders',style: TextStyle(color: Colors.orange,fontSize: 20),),
          onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyOrders())),
        ),
        Divider(color:Colors.orange),
        ListTile(
          leading: Icon(Icons.desktop_access_disabled,color: Colors.orange,size: 30,),
          title: Text('LogOut',style: TextStyle(color: Colors.orange,fontSize: 20),),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
          },
        ),

      ],
    ),
  );
}
