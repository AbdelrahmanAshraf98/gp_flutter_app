import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gp_flutter_app/layout/home_layout.dart';
import 'package:gp_flutter_app/modules/login/login_screen.dart';
import 'package:gp_flutter_app/modules/welcome/welcome_screen.dart';
import 'package:gp_flutter_app/shared/bloc_observer.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';
import 'package:gp_flutter_app/shared/network/local/cache_helper.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';


import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'modules/chat/chat_screen.dart';
import 'modules/medical_records/records_screen.dart';
import 'modules/profile/Profile_screen.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('drug');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,);

  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  bool onBoarding = CacheHelper.getData(key: 'onBoard');
  Widget startScreen;
  if (onBoarding != null) {
    if (uId != null)
      startScreen = HomeLayout();
    else
      startScreen = LoginScreen();
  } else
    startScreen = WelcomeScreen();

  runApp(MyApp(startScreen));
}

class MyApp extends StatelessWidget {
  Widget startScreen;
  MyApp(this.startScreen);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUser()..getPosts(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state) {
          return MaterialApp(
            title: 'GP',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primaryColor: Color(0xff00B0FF),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Color(0xff00B0FF),
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                )),
            debugShowCheckedModeBanner: false,
            home: startScreen,
          );
        } ,
      ),
    );
  }
}
