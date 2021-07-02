import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter_app/modules/login/login_screen.dart';
import 'package:gp_flutter_app/modules/register/register_screen.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/network/local/cache_helper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CacheHelper.saveData(key: 'onBoard', value: true);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).primaryColor.withOpacity(0.75),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 120.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'App Name',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'App Slogan Here',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18.0, letterSpacing: 5),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        navigateAndFinish(LoginScreen(),context);
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        navigateAndFinish(RegisterScreen(),context);
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
