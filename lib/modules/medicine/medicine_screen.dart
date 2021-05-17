import 'package:flutter/material.dart';
import 'package:gp_flutter_app/shared/components/components.dart';

class MedicineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/medicine.jpg')),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.delete,color: Colors.white,),
                          SizedBox(width: 10.0,),
                          Icon(Icons.edit,color: Colors.white,),
                        ],
                      ),
                    ],
                  ),
                )
              ),

            ],),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Dawa Gamed',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 40.0,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(35.0),
                      color: Colors.white,
                      child: Center(child: Text('02:00 PM',style: TextStyle(fontSize: 18.0,color: Color(0xff707070),fontWeight: FontWeight.w600),)),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(35.0),
                      color: Colors.white,
                      child: Center(child: Text('10:00 PM',style: TextStyle(fontSize: 18.0,color: Color(0xff707070),fontWeight: FontWeight.w600),)),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(35.0),
                      color: Colors.white,
                      child: Center(child: Text('06:00 AM',style: TextStyle(fontSize: 18.0,color: Color(0xff707070),fontWeight: FontWeight.w600),)),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  defaultButton(text: 'Set a remainder', function: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
