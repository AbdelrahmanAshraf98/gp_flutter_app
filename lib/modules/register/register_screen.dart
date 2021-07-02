import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/home_layout.dart';
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
              navigateAndFinish(HomeLayout(), context);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage('assets/images/form.png'),
                      ),
                      Center(
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
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
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(35.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: DropdownButton<String>(
                                value: RegisterCubit.get(context).dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                underline: Container(
                                  height: 2,
                                  color: kPrimary,
                                ),
                                onChanged: (String newValue) {
                                  RegisterCubit.get(context).changeDropValue();
                                  print(newValue);
                                },
                                items: [
                              DropdownMenuItem(value:'user',child: Text('User')),
                              DropdownMenuItem(value:'doctor',child: Text('Doctor')),
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                          text: 'Register',
                          color: kPrimary,
                          function: () {
                            RegisterCubit.get(context).userRegister(
                                name:nameController.text,
                                age: ageController.text ,
                                email: emailController.text,
                                password: passwordController.text,
                                type: RegisterCubit.get(context).dropdownValue,
                            );
                          },
                          radius: 0,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
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
