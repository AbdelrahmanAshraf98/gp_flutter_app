import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';

class ChatScreen extends StatelessWidget {
  var msgController = TextEditingController();
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getMessages(receiverID: 'admin');
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var messages = AppCubit.get(context).messages;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              elevation: 0,
              centerTitle: true,
              title: Text('Chat With Doctor'),
              backgroundColor: Theme.of(context).primaryColor,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Theme.of(context).primaryColor,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(right: 15.0 , left: 15.0,top: 10.0,bottom: 10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (messages[index].senderID != uId)
                          return bubble(
                            messages[index].text,
                            messages[index].image,
                            context,
                          );
                        return myBubble(
                          messages[index].text,
                          messages[index].image,
                          context,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.0,
                      ),
                      itemCount: messages.length,
                    ),
                  ),
                  if(state is ChatImageUploadLoadingState)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: LinearProgressIndicator(),
                  ),
                  //message text field
                  Padding(
                    padding: const EdgeInsets.only(top : 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(35.0),
                            elevation: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                controller: msgController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  // suffix: IconButton(onPressed: (){},icon: Icon(Icons.camera_alt_outlined),color: kPrimary,),
                                  hintText: '  Type Your Message....',
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              AppCubit.get(context).getChatImageGallery();
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: kPrimary,
                            )),
                        SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () {
                            if (msgController.text != '' || AppCubit.get(context).chatImageUrl != null)
                              AppCubit.get(context).sendMessage(
                                dateTime: DateTime.now().toString(),
                                text: msgController.text,
                                image: AppCubit.get(context).chatImageUrl,
                                receiverID: 'admin',
                              );
                            msgController.clear();
                            scrollController.jumpTo(scrollController.position.maxScrollExtent);
                          },
                          child: CircleAvatar(
                            backgroundColor: state is ChatImageUploadLoadingState?Colors.grey:Theme.of(context).primaryColor,
                            radius: 25,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

Widget myBubble(String txt, String image, context) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Material(
        elevation: 3.0,
        color: Color(0xffEAEAEA),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          topLeft: Radius.circular(24.0),
          bottomLeft: Radius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              if (image != null && image != '')
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Image(
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              Text(
                txt,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget bubble(String txt, String image, context) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Material(
        elevation: 3.0,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          topLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              if (image != null && image != '')
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: Image(
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              Text(
                txt,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
