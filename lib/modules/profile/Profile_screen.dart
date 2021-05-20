import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter_app/shared/components/components.dart';

class ProfileScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      drawer: Drawer(child: drawerMenu(context),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Stack(
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                              Text('Cairo'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(35.0),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: '  Enter Drug name..',
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
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 3.0,
                    child: Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 150.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/medicine.jpg')),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dawa Gamed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Next Dose : 02:00 PM',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 3.0,
                    child: Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 150.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/medicine.jpg')),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dawa Gamed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Next Dose : 02:00 PM',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 3.0,
                    child: Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 150.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/medicine.jpg')),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dawa Gamed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Next Dose : 02:00 PM',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 3.0,
                    child: Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 150.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/medicine.jpg')),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dawa Gamed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Next Dose : 02:00 PM',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
