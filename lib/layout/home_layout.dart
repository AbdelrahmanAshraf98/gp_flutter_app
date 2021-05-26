import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/modules/chat/chat_screen.dart';
import 'package:gp_flutter_app/modules/interactions_checker/interactions_checker_screen.dart';
import 'package:gp_flutter_app/modules/profile/Profile_screen.dart';
import 'package:gp_flutter_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is GetUserLoadingState,
          builder:  (context) =>  Container(color:Colors.white,child: Center(child: CircularProgressIndicator(),)),
          fallback: (context) => Scaffold(
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
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(AppCubit.get(context).userModel.image),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              AppCubit.get(context).userModel.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        onTap: (){
                          navigateTo(ProfileScreen(), context);
                        },
                        leading: Icon(Icons.person),
                        title: Text('Profile'),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: Icon(Icons.medical_services),
                        title: Text('My Medicines'),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: Icon(Icons.device_thermostat),
                        title: Text('My Records'),
                      ),
                      ListTile(
                        onTap: (){
                          navigateTo(ChatScreen(), context);
                        },
                        leading: Icon(Icons.chat),
                        title: Text('Chat with doctor'),
                      ),
                    ],
                  ),
                  ListTile(
                    onTap: (){},
                    leading: Icon(Icons.logout),
                    title: Text('Log Out'),
                  ),
                ],
              ),),
            body: InteractionCheckerScreen(),
          ),
        );
      },
    );
  }
}
