import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/models/user_model.dart';
import 'package:gp_flutter_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
  @required String email,
  @required String password,
  @required String name,
  @required String age,
})
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      emit(RegisterSuccessState(value.user.uid));
      createUser(name: name ,email: email,uId:value.user.uid,age: age);
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    @required String name,
    @required String email,
    @required String uId,
    @required String age,
  }) {
    emit(CreateUserLoadingState());
    UserModel userModel = UserModel(
      email: email,
      name: name,
      age: age,
      userID: uId,
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWVzMB3E95aVYeCB9XtBkPYLryqIC7NPIYYQ&usqp=CAU',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState());
    });
  }

  bool isPassword = true;
  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangeRegisterPasswordVisibilityState());
  }

}