import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/modules/login/cubit/cubit.dart';
import 'package:gp_flutter_app/modules/login/cubit/states.dart';
import 'package:gp_flutter_app/modules/profile/Profile_screen.dart';
import 'package:gp_flutter_app/modules/register/register_screen.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';
import 'package:gp_flutter_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState)
            showToast(msg: state.error, color: Colors.red);
          if (state is LoginSuccessState) {
            showToast(msg: 'Logged in successfully', color: Colors.green);
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(ProfileScreen(), context);
            });
          }
        },
        builder: (context, state) {
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
                        suffix: LoginCubit.get(context).isPassword?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                        suffixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                        isPassword: LoginCubit.get(context).isPassword,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        text: 'Login',
                        color: kPrimary,
                        function: () {
                          LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                        },
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
                                navigateAndFinish(RegisterScreen(),context);
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
        },
      ),
    );
  }
}
