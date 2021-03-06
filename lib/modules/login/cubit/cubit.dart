import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/modules/login/cubit/states.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(FirebaseAuth.instance.currentUser.email);
      uId = FirebaseAuth.instance.currentUser.uid;
      emit(LoginSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

}