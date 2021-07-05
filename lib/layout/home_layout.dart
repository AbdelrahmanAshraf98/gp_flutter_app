import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/modules/chat/chat_screen.dart';
import 'package:gp_flutter_app/modules/interactions_checker/interactions_checker_screen.dart';
import 'package:gp_flutter_app/modules/login/cubit/cubit.dart';
import 'package:gp_flutter_app/modules/login/login_screen.dart';
import 'package:gp_flutter_app/modules/profile/Profile_screen.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getUser();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (state is GetUserLoadingState && AppCubit.get(context).userModel == null) || state is SignOutLoadingState,
          builder: (context) => Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              )),
          fallback: (context) => Scaffold(
            appBar: AppBar(
              leading:  IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              title: Center(
                  child: Text(
                AppCubit.get(context)
                    .titles[AppCubit.get(context).currentScreen],
                style: TextStyle(color: Colors.white),
              )),
              actions: [
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      AppCubit.get(context).signOut().then(
                          (value) => navigateAndFinish(LoginScreen(), context));
                    })
              ],
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: kPrimary,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            backgroundColor: Colors.white,
            body: AppCubit.get(context)
                .screens[AppCubit.get(context).currentScreen],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                AppCubit.get(context).changeBottomNav(index);
              },
              currentIndex: AppCubit.get(context).currentScreen,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_box), label: 'Checker'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/drug.png',height: 24.0,), label: 'Identifier'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.article_rounded), label: 'Blog'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.analytics), label: 'Records'),
              ],
            ),
          ),
        );
      },
    );
  }
}
