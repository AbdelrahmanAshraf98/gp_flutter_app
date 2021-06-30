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
  @required String type,
})
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.uid);
      emit(RegisterSuccessState(value.user.uid));
      createUser(name: name ,email: email,uId:value.user.uid,age: age,type:type);
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    @required String name,
    @required String email,
    @required String uId,
    @required String age,
    @required String type,
  }) {
    emit(CreateUserLoadingState());
    if(type == 'doctor')
      name='Dr/ '+name;
    UserModel userModel = UserModel(
      email: email,
      name: name,
      age: age,
      userID: uId,
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWVzMB3E95aVYeCB9XtBkPYLryqIC7NPIYYQ&usqp=CAU',
      type: type,
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

  String dropdownValue = 'user';
  changeDropValue(){
    if(dropdownValue == 'user')
      dropdownValue = 'doctor';
    else
      dropdownValue = 'user';
    emit(ChangeDropValueSuccessState());
  }

}