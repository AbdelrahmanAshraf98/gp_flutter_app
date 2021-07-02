import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:gp_flutter_app/models/drug_model.dart';
import 'package:gp_flutter_app/models/message_model.dart';
import 'package:gp_flutter_app/models/post_model.dart';
import 'package:gp_flutter_app/models/user_model.dart';
import 'package:gp_flutter_app/modules/blog/blog_screen.dart';
import 'package:gp_flutter_app/modules/chat/chat_screen.dart';
import 'package:gp_flutter_app/modules/interactions_checker/interactions_checker_screen.dart';
import 'package:gp_flutter_app/modules/login/login_screen.dart';
import 'package:gp_flutter_app/modules/medical_records/records_screen.dart';
import 'package:gp_flutter_app/modules/profile/Profile_screen.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';
import 'package:gp_flutter_app/shared/network/local/cache_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel userModel;
  int currentScreen = 0;
  List<DrugModel> drugs = [];
  List<String> drugsID = [];
  List<List<String>> dose = [];

  var picker = ImagePicker();

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId');
      uId = '';
      userModel = null;
      drugs = [];
      drugsID = [];
      currentScreen = 0;
      emit(SignOutSuccessState());
    }).catchError((error){
      emit(SignOutErrorState());
    });
  }
  List<Widget> screens = [
    ProfileScreen(),
    ChatScreen(),
    InteractionCheckerScreen(),
    BlogScreen(),
    RecordsScreen(),
  ];
  List<String> titles = [
    'Profile',
    'Chat With Dr',
    'Interaction Checker',
    'Blog',
    'Records',
  ];

  void changeBottomNav(int index) {
    currentScreen = index;
    emit(BottomNavigationState());
  }

  void getUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
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
        MessageModel(text, receiverID, userModel.userID, dateTime, image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.userID)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
      if (chatImageUrl != null) removeChatImage();
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
      });
      emit(GetMessagesSuccessState());
    });
  }

  void addDrug({
    @required String name,
  }) {
    DrugModel model = DrugModel(name,'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        'https://www.health.qld.gov.au/__data/assets/image/0022/672052/varieties/385-md.jpg',null);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.userID)
        .collection('drugs')
        .add(model.toMap())
        .then((value) {
      emit(AddDrugSuccessState());
      if (chatImageUrl != null) removeChatImage();
    }).catchError((error) {
      emit(AddDrugErrorState());
    });
  }

  void getDrugs() {
    emit(GetDrugsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('drugs')
        .get()
        .then((value){
              drugs = [];
              drugsID = [];
              value.docs.forEach((element) {
                drugs.add(DrugModel.fromJson(element.data()));
                drugsID.add(element.id);
                print('Drug :::::::: ' + element.data().toString());
              });
              emit(GetDrugsSuccessState());
            })
        .catchError((error) {
      emit(GetDrugsErrorState());
      print('Error ::::::: ${error}');
    });
  }

  void addDose({
    @required String id,
    @required DrugModel drug,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.userID)
        .collection('drugs')
        .doc(id)
        .set({
      'dose': drug.dose,
      'image':drug.image,
      'text':drug.text,
      'name':drug.name,
    }).then((value) {
      emit(AddDoseSuccessState());
      getDrugs();
    }).catchError((error) {
      emit(AddDoseErrorState());
    });
  }

  void deleteDrug({
    @required String id,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.userID)
        .collection('drugs')
        .doc(id)
        .delete()
        .then((value){
          getDrugs();
      emit(DeleteDrugSuccessState());
    }).catchError((error) {
      emit(DeleteDrugErrorState());
    });
  }

  String nextDose(List<dynamic> dose){
    if(dose != null) {
        if(dose.length == 1 )
          return dose[0];
        else
          for (int i = 0; i < dose.length; i++) {
            var now = DateFormat.jm().format(DateTime.now());
            if (parseTime(now).compareTo(parseTime(dose[i])) < 0) {
              return dose[i];
            }
          }

    }
    return '';
  }
  String postImageUrl = '';
  void uploadPostImage() {
    emit(PostImageUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(PostImageUploadSuccessState());
        postImageUrl = value;
      }).catchError((onError) {
        emit(PostImageUploadErrorState());
      });
    }).catchError((error) {
      emit(PostImageUploadErrorState());
    });
  }

  File postImage;
  Future<void> getPostImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(PostImagePickedSuccessState());
      uploadPostImage();
    } else {
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostImageRemoveState());
  }

  void createNewPost({
    @required String text,
    @required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    PostModel post = PostModel(
      image: userModel.image,
      name: userModel.name,
      userID: uId,
      text: text,
      dateTime: dateTime,
      postImage: postImageUrl != '' ? postImageUrl : null,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap())
        .then((value) {
      removePostImage();
      emit(CreatePostSuccessState());
      getPosts();
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsID = [];
  List<int> postsLikes = [];
  List<String> postsLang = [];

  void getPosts() {
    emit(HomeGetPostsLoadingState());
    posts = [];
    postsID = [];
    postsLikes = [];
    postsLang = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsLang.add(checkLang(PostModel.fromJson(element.data()).text).toString());
          postsID.add(element.id);
        });
      });
      emit(HomeGetPostsSuccessState());
    }).catchError((error) {
      emit(HomeGetPostsErrorState());
    });
  }

  void likePost({String postId,int index}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uId)
        .set({'like': true}).then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .get()
          .then((value) {
            postsLikes[index] = value.docs.length;
            emit(LikePostSuccessState());
      });
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }
  void dislike({String postId,int index}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uId)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .get()
          .then((value) {
        postsLikes[index] = value.docs.length;
        emit(DisLikePostSuccessState());
      });
    }).catchError((error) {
      emit(DisLikePostErrorState());
    });
  }

}
