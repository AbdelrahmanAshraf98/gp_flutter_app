import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';

class InteractionCheckerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(300),
                        bottomRight: Radius.circular(300),
                      )),
                  height: 550,
                  width: double.infinity,
                ),
                Image(
                  width: double.infinity,
                  image: AssetImage('assets/images/circles.png'),
                  color: Colors.white.withOpacity(0.3),
                ),
                Container(
                  height: 550,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            height: 100,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  height: 55.0,
                                  color: Colors.amber,
                                  width: 5.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  child: Text(
                                    'Welcome to Drug Interactions Checker',
                                    style: TextStyle(
                                      fontSize: 26.0,
                                      color: kPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  width: 250,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        'Check drug interactions now',
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Enter drug name',
                        style: TextStyle(
                            fontSize: 18.0, color: Colors.white, letterSpacing: 2),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(35.0),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Enter Drug name..',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(35.0),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Enter Drug name..',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Material(
                          color: Colors.amberAccent,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(35),
                          elevation: 3.0,
                          child: Container(
                            height: 50.0,
                            width: 200,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                'CHECK',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check,color: Colors.green,size: 24.0,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('No Interactions',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
