import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main/MyOrders.dart';
import '../main/addnote.dart';
import '../main/editnote.dart';
import '../main/main.dart';
import 'create.dart';
import 'order_page.dart';
class ReadPage extends StatefulWidget {

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Order'),
      ),
      drawer: NavigationDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        // <2> Pass `Stream<QuerySnapshot>` to stream
          stream: FirebaseFirestore.instance.collection('Borders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // <3> Retrieve `List<DocumentSnapshot>` from snapshot
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView(
                  children: documents
                      .map((doc) =>
                      Card(
                        child: ListTile(
                          title: Text(doc['name']),
                          subtitle: Text(doc['size']),
                        ),
                      ))
                      .toList());
            } else if (snapshot.hasError) {
              return Text('there is an Error!');
            }
            return Center(
              child: SpinKitSpinningLines(
                color: Colors.orange,
                size: 150.0,
              ),);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => OrderPage()));
        },
      ),
    );
  }

  Widget buildOrder(Order order) =>
      ListTile(
        leading: CircleAvatar(child: Text('${order.size}'),),
        title: Text(order.name),
        subtitle: Text(order.items),
      );

  Stream<List<Order>> readOrders() =>
      FirebaseFirestore.instance.collection('Borders').snapshots().map((
          snapshot) =>
          snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
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
          onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderPage())),
        ),
        Divider(color:Colors.orange),
        ListTile(
          leading: Icon(Icons.add_shopping_cart,color: Colors.orange,size: 30,),
          title: Text('Add Item',style: TextStyle(color: Colors.orange,fontSize: 20),),
          onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderPage())),
        ),
        Divider(color:Colors.orange),
        ListTile(
          leading: Icon(Icons.shopping_cart_outlined,color: Colors.orange,size: 30,),
          title: Text('My Orders',style: TextStyle(color: Colors.orange,fontSize: 20),),
          onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReadPage())),
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
