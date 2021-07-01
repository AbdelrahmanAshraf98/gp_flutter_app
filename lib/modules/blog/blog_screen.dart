import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:gp_flutter_app/modules/new_post/new_post_screen.dart';
import 'package:gp_flutter_app/shared/components/components.dart';

class BlogScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              if (AppCubit.get(context).userModel.type == 'doctor')
                Container(
                    color: Colors.white60,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    AppCubit.get(context).userModel.image),
                                radius: 15.0,
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
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: Center(
                                child: Text(
                              'Write your article here..',
                              style: TextStyle(color: Colors.grey),
                            ))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: OutlinedButton(
                            onPressed: () {
                              navigateTo(NewPostScreen(), context);
                            },
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        )
                      ],
                    )),
              ListView.builder(
                itemBuilder: (context, index) => buildPost(
                    context, AppCubit.get(context).posts[index],
                    index,AppCubit.get(context).postsLang[index].toString()),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: AppCubit.get(context).posts.length,
              )
            ],
          ),
        );
      },
    );
  }
}
