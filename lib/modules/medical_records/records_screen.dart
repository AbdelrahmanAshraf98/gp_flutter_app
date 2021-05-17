import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
            height: 200,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 90.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/images/pp.jpg'),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abd Elrahman Ashraf',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16.0),
                            ),
                            Text('Cairo'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 3.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Image(image: AssetImage('assets/images/blood.png'),)),
                                SizedBox(height: 5.0,),
                                Text('Blood Pressure',style: TextStyle(fontSize: 12.0,color: Colors.black54),),
                                Text('70 bps',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 3.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Image(image: AssetImage('assets/images/heart.png'),)),
                                SizedBox(height: 5,),
                                Text('Blood Beats',style: TextStyle(fontSize: 12.0,color: Colors.black54),),
                                Text('120 bps',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.0,),
                  Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 3.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Image(image: AssetImage('assets/images/heart.png'),)),
                                SizedBox(height: 5,),
                                Text('Blood Beats',style: TextStyle(fontSize: 12.0,color: Colors.black54),),
                                Text('120 bps',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 3.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Image(image: AssetImage('assets/images/blood.png'),)),
                                SizedBox(height: 5.0,),
                                Text('Blood Pressure',style: TextStyle(fontSize: 12.0,color: Colors.black54),),
                                Text('70 bps',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Expanded(child: Image(image: AssetImage('assets/images/doctors.png'),))
            ],
          )
        ],
      ),
    );
  }
}
