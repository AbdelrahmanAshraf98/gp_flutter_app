import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_flutter_app/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  var msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(toolbarHeight: 60,
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
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Material(
                          elevation: 3.0,
                          color: Color(0xffEAEAEA),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24.0),
                              topLeft: Radius.circular(24.0),
                              bottomLeft: Radius.circular(24.0),
                            ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Dr please I want to ask a question',style: TextStyle(fontSize:16.0,),),
                          ),
                        ),
                      ],
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            elevation: 3.0,
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24.0),
                              topLeft: Radius.circular(24.0),
                              bottomRight: Radius.circular(24.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Yes , Sure',style: TextStyle(fontSize:16.0,color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column  (
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Material(
                            elevation: 3.0,

                            color: Color(0xffEAEAEA),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24.0),
                              topLeft: Radius.circular(24.0),
                              bottomLeft: Radius.circular(24.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('does asparin has any side effects with keporex',style: TextStyle(fontSize:16.0,),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            elevation: 3.0,
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24.0),
                              topLeft: Radius.circular(24.0),
                              bottomRight: Radius.circular(24.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Yes , it causes increase in temp sometimes',style: TextStyle(color:Colors.white,fontSize:16.0,),),
                            ),
                          ),
                        ],
                      ),
                    )
                ],),
              ),
              SizedBox(height: 470,),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(35.0),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: msgController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
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
                  SizedBox(width: 5.0,),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 25,
                    child: Icon(Icons.send,color: Colors.white,),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
