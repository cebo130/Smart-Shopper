import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopper/angry/read.dart';

import '../main/MyOrders.dart';
import '../main/main.dart';
import 'create.dart';
class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final controllName = TextEditingController();
  final controllSize = TextEditingController();
  final controllItems = TextEditingController();
  //reference a document

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Order'),
      ),
      drawer: NavigationDrawer(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: controllName,
            decoration: decoration('Name'),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllSize,
            decoration: decoration('Size'),
            //keyboardType:,
          ),
          SizedBox(height: 24),
          TextField(
            controller: controllItems,
            decoration: decoration('items'),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            child: Text('Create'),
            onPressed: (){
              final order = Order(
                //id: docUser.id,
                name: controllName.text,
                size: controllSize.text,
                items: controllItems.text,
              );
              createOrder(order);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReadPage()));
            },
          ),
        ],
      ),
    );
  }

  Future createOrder(Order order) async {
    final docUser = FirebaseFirestore.instance.collection('Borders').doc('qWEyre-4');
    //docUser.id = user.id;
    order.id = docUser.id;
    final json = order.toJson();
    await docUser.set(json);
  }
  InputDecoration decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
  );
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
