import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/modules/login/login_screen.dart';
import 'package:gp_flutter_app/modules/profile/Profile_screen.dart';
import 'package:gp_flutter_app/modules/register/cubit/cubit.dart';
import 'package:gp_flutter_app/modules/register/cubit/states.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';
import 'package:gp_flutter_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState)
            showToast(msg: state.error, color: Colors.red);
          if (state is RegisterSuccessState) {
            showToast(msg: 'Account created successfully', color: Colors.green);
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
                        image: AssetImage('assets/images/form.png'),
                      ),
                      Text(
                        'Register',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextField(
                        prefix: Icons.person_outline,
                        type: TextInputType.text,
                        label: 'Name',
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 15.0,
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
                        suffix: RegisterCubit.get(context).isPassword?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        isPassword: RegisterCubit.get(context).isPassword,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                        prefix: Icons.date_range,
                        type: TextInputType.number,
                        label: 'Age',
                        controller: ageController,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        text: 'Register',
                        color: kPrimary,
                        function: () {
                          RegisterCubit.get(context).userRegister(name:nameController.text, age: ageController.text ,email: emailController.text, password: passwordController.text);
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
                            'Have an account?',
                            style: TextStyle(),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateAndFinish(LoginScreen(),context);
                              },
                              child: Text(
                                'Login Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimary,
                                ),
                              )),
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
