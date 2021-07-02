import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/models/user_model.dart';
import 'package:gp_flutter_app/modules/register/cubit/states.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';

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
      uId = FirebaseAuth.instance.currentUser.uid;
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
      name = 'Dr/ '+name;
    UserModel userModel = UserModel(
      email: email,
      name: name,
      age: age,
      userID: uId,
      image:
      type == 'doctor'?
      'https://image.freepik.com/free-photo/portrait-successful-mid-adult-doctor-with-crossed-arms_1262-12865.jpg'
      :'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg'
      ,type: type,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      uId = FirebaseAuth.instance.currentUser.uid;
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