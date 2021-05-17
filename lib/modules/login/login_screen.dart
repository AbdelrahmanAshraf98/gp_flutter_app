import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter_app/modules/register/register_screen.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/login.png'),
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultTextField(
                  prefix: Icons.mail_outline,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  controller: emailController,
                ),
                SizedBox(
                  height: 15.0,
                ),
                defaultTextField(
                  prefix: Icons.lock_outline,
                  type: TextInputType.text,
                  label: 'Password',
                  controller: passwordController,
                  suffix: Icons.remove_red_eye_outlined,
                  suffixPressed: () {},
                  isPassword: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  text: 'Login',
                  color: kPrimary,
                  function: () {},
                  radius: 0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(),
                    ),
                    TextButton(
                        onPressed: () {
                          navigateTo(RegisterScreen(),context);
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimary,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
