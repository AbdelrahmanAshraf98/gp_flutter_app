import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:intl/intl.dart' as intl;

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Create Post',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: TextButton(
                      onPressed: () {
                        AppCubit.get(context).createNewPost(
                            text: textController.text,
                            dateTime: DateTime.now().toString());
                        if (state is CreatePostSuccessState) {
                          textController.text = '';
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'POST',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState) LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  SizedBox(
                    height: 5.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(AppCubit.get(context).userModel.image),
                      radius: 20.0,
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppCubit.get(context).userModel.name,
                            style: TextStyle(
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: textController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'What\'s on your mind, Dr?',
                        border: InputBorder.none),
                  ),
                ),
                if (AppCubit.get(context).postImage != null)
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                image:
                                    FileImage(AppCubit.get(context).postImage),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 20.0,
                            child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  AppCubit.get(context).removePostImage();
                                }),
                          ),
                        ),
                        if (state is PostImageUploadLoadingState)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: LinearProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          AppCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
