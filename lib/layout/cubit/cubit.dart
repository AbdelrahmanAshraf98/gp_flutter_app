import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:gp_flutter_app/models/message_model.dart';
import 'package:gp_flutter_app/models/user_model.dart';
import 'package:gp_flutter_app/modules/chat/chat_screen.dart';
import 'package:gp_flutter_app/modules/medical_records/records_screen.dart';
import 'package:gp_flutter_app/modules/profile/Profile_screen.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  var picker = ImagePicker();


  List<Widget> screens = [
    ProfileScreen(),
    //TODO::screen()
    RecordsScreen(),
    ChatScreen(),
  ];

  int currentScreen  = 0;
  void drawerNavigation(int index){
    print('Drawer:::::::::::::'+index.toString());
      currentScreen = index;
      emit(DrawerNavigationState());
  }

  void getUser(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          userModel = UserModel.fromJson(value.data());
       print(userModel.image);
       emit(GetUserSuccessState());
    }).catchError((error){
      emit(GetUserErrorState());
    });
  }

  String chatImageUrl = '';
  void uploadChatImage() {
    emit(ChatImageUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('photos/${Uri.file(chatImage.path).pathSegments.last}')
        .putFile(chatImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(ChatImageUploadSuccessState());
        chatImageUrl = value;
        print(value);
      }).catchError((onError) {
        emit(ChatImageUploadErrorState());
      });
    }).catchError((error) {
      emit(ChatImageUploadErrorState());
    });
  }

  File chatImage;
  Future<void> getChatImageGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      chatImage = File(pickedImage.path);
      emit(ChatImagePickedSuccessState());
      uploadChatImage();
    } else {
      emit(ChatImagePickedErrorState());
    }
  }

  void removeChatImage() {
    chatImage = null;
    chatImageUrl = null;
    emit(ChatImageRemoveState());
  }

  void sendMessage({
    @required String text,
    @required String dateTime,
    @required String receiverID,
    String image,
  }) {
    MessageModel model =
    MessageModel(text, receiverID, userModel.userID, dateTime,image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.userID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
      if(chatImageUrl != null)
        removeChatImage();
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userModel.userID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({@required String receiverID}) {
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.userID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        print(element.data());
      });
      emit(GetMessagesSuccessState());
    });
  }

}
