import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'addnote.dart';


class LocationPage extends StatelessWidget {
  @override
  bool ceb = false;

  final List<String> storeLocations = [
    'Town',
    'Scottsville',
  ];
  final List<String> pickupLocations = [
    'Dennison Res',
    'Pelham',
    'Sai Mews',
    'Alexandra 13',
    '162 by seaboard',
    'Absa res',
    'Sai Villa',
    'Bruxien',
    'Melherbe',
    'Maingate(campus M6 gate)',
    'other',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: [
          SizedBox(height:40),
          Row(
            children: [
              Container(
                width: 260,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(3))
                ),
                padding: EdgeInsets.only(left:30, top: 3, right:0, bottom: 0),
                child: Text("Smart Shopper",style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
              SizedBox(width:17),
              Image.asset('assets/images/cebo.png',scale: 7,),
            ],
          ),
          SizedBox(height:90),
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
                      'Store location',
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
                    items: storeLocations
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
                        return 'Please select store location.';
                      }
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),/*DropDownFormField2*/
                  const SizedBox(height: 30),
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
                    ),/*InputDecoration*/
                    isExpanded: true,
                    hint: const Text(
                      'Pick-up location',
                      style: TextStyle(fontSize: 14),
                    ),/*Text*/
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.orange,
                    ),/*Icon*/
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),/*BoxDirection*/
                    items: pickupLocations
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select pick-up location.';
                      }else{
                        ceb = true;
                      }
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                      ceb = true;

                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),/*DropDowButtonFormField2*/
                  const SizedBox(height: 60),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                          }
                          if(ceb==true){
                            /*Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (_) => addnote()));*/
                            print(selectedValue);
                          }

                        },
                        child: Text("Next",style:TextStyle(color:Colors.white,fontSize: 22),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
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
        ],
      ),
    );
  }
}


