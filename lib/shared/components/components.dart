import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/models/drug_model.dart';
import 'package:gp_flutter_app/models/post_model.dart';
import 'package:gp_flutter_app/modules/medicine/medicine_screen.dart';
import 'package:intl/intl.dart' as intl;
import 'constants.dart';

void showToast({@required String msg, @required Color color}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget defaultButton({
  @required String text,
  @required Function function,
  double radius = 35.0,
  Color color = kPrimary,
}) =>
    Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData prefix,
  bool isPassword = false,
  Function onSubmit,
  Function suffixPressed,
  IconData suffix,
  Function onTap,
  @required Function validation,
}) =>
    Material(
      borderRadius: BorderRadius.circular(35.0),
      elevation: 3,
      child: TextFormField(
        onTap: onTap,
        onFieldSubmitted: onSubmit,
        obscureText: isPassword,
        controller: controller,
        validator: validation,
        keyboardType: type,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: suffixPressed,
                )
              : null,
        ),
      ),
    );

navigateTo(Widget screen, context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ));

navigateAndFinish(Widget screen, context) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ), (route) {
      return false;
    });

Widget drawerMenu({context, @required String name, @required String image}) {
  return Column(
    children: [
      DrawerHeader(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(image),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      ),
      Spacer(),
      ListTile(
        onTap: () {},
        leading: Icon(Icons.logout),
        title: Text('Log Out'),
      ),
    ],
  );
}

Widget drugCard(context, DrugModel model, String id) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 3.0,
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  navigateTo(MedicineScreen(model, id), context);
                },
                child: Container(
                  width: 150.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(model.image)),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateTo(MedicineScreen(model, id), context);
                      },
                      child: Text(
                        model.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      AppCubit.get(context).nextDose(model.dose) != ''?
                      'Next Dose : ' +
                          AppCubit.get(context).nextDose(model.dose):'No Doses',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          AppCubit.get(context).deleteDrug(id: id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text('Delete'),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget timeCard(String time) => Container(
      width: double.infinity,
      height: 50,
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(35.0),
        color: Colors.white,
        child: Center(
            child: Text(
          time,
          style: TextStyle(
              fontSize: 18.0,
              color: Color(0xff707070),
              fontWeight: FontWeight.w600),
        )),
      ),
    );
Future<String> checkLang(String text)async{
  final LanguageIdentifier languageIdentifier = FirebaseLanguage.instance.languageIdentifier();
  final List<LanguageLabel> labels = await languageIdentifier.processText(text);
  for (LanguageLabel label in labels) {
    final String text = label.languageCode;
    final double confidence = label.confidence;
  }
  return labels[0].languageCode;
}
Widget buildPost(context, PostModel model, int index ) => Card(
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(model.image),
                  radius: 25.0,
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name,
                            style: TextStyle(
                                height: 1.4, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: kPrimary,
                            size: 15.0,
                          )
                        ],
                      ),
                      Text(
                        model.dateTime
                            .substring(0, 16)
                            .replaceRange(10, 11, ' at '),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.0),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text,
              // textAlign: AppCubit.get(context).postsLang[index] == 'ar' ?TextAlign.right:TextAlign.left,
              textDirection:TextDirection.rtl,
            ),
            if (model.postImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(model.postImage),
                    ),
                  ),
                ),
              ),
            //separator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            //likes and comments
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          AppCubit.get(context).postsLikes[index].toString() + ' Likes',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).likePost(
                                postId: AppCubit.get(context).postsID[index],
                                index: index,
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up_rounded,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Like',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15.0,),
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).dislike(
                                postId: AppCubit.get(context).postsID[index],
                                index: index,
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_down_rounded,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Dislike',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

/// Parses a time of the form 'hh:mm AM' or 'hh:mm PM' to a 24-hour
/// time represented as an int.
///
/// For example, parses '3:30 PM' as 1530.
int parseTime(String time) {
  var components = time.split(RegExp('[: ]'));
  if (components.length != 3) {
    throw FormatException('Time not in the expected format: $time');
  }
  var hours = int.parse(components[0]);
  var minutes = int.parse(components[1]);
  var period = components[2].toUpperCase();

  if (hours < 1 || hours > 12 || minutes < 0 || minutes > 59) {
    throw FormatException('Time not in the expected format: $time');
  }

  if (hours == 12) {
    hours = 0;
  }

  if (period == 'PM') {
    hours += 12;
  }

  return hours * 100 + minutes;
}

// int greater(String element, String element2) {
//   var hour = element.toString().split(':')[0];
//   var hour2 = element2.toString().split(':')[0];
//   var minute = element.toString().split(':')[1].split(' ')[0];
//   var minute2 = element2.toString().split(':')[1].split(' ')[0];
//   var day = element.toString().split(':')[1].split(' ')[1];
//   var day2 = element2.toString().split(':')[1].split(' ')[1];
//   if (day == 'AM' && day2 == 'PM')
//     return -1;
//   else if (day2 == 'AM' && day == 'PM')
//     return 1;
//   else if (day == day2) {
//     if (int.parse(hour) > int.parse(hour2))
//       return -1;
//     else if (int.parse(hour) < int.parse(hour2))
//       return 1;
//     else {
//       if (int.parse(minute) > int.parse(minute2))
//         return 1;
//       else
//         return -1;
//     }
//   }
//   // dose.forEach((element) {
//   //   print(element.toString().split(':')[0]);
//   //   print(element.toString().split(':')[1].split(' ')[0]);
//   //   print(element.toString().split(':')[1].split(' ')[1]);
//   // });
// }

// void printo(DrugModel model) {
//   print(model.dose);
//   model.dose.forEach((element) {
//     if(element.compareTo(DateFormat.jm().format(DateTime.now()))>0)
//     print(element); // 2020-04-03 00:00:00.000
//   });
//
//   // print(model.dose);
// }
