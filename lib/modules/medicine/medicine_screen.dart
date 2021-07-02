import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:gp_flutter_app/models/drug_model.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../main.dart';

class MedicineScreen extends StatelessWidget {
  final DrugModel model;
  final String id;
  var timeController = TextEditingController();

  MedicineScreen(this.model, this.id);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'info',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).deleteDrug(id: id);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(model.image)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        model.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        model.text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: model.dose != null,
                        fallback: (context) => Center(
                            child: Column(
                          children: [
                            Text(
                              'Add your remainders now !',
                              style: TextStyle(color: kPrimary, fontSize: 16.0),
                            ),
                            Image.asset('assets/images/dose.png'),
                          ],
                        )),
                        builder: (context) => ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                timeCard(model.dose[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.0,
                                ),
                            itemCount: model.dose.length),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        text: 'Set a remainder',
                        function: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Container(
                                height: 150.0,
                                child: Column(
                                  children: [
                                    Text(
                                      'Pick Dose Time',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    defaultTextField(
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value.format(context);
                                        });
                                      },
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      label: 'Time',
                                      prefix: Icons.timer,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50.0),
                                      child: defaultButton(
                                        text: 'ADD',
                                        function: () {
                                          if (timeController.text != '') {
                                            if (model.dose == null)
                                              model.dose = [
                                                timeController.text
                                              ];
                                            else {
                                              model.dose
                                                  .add(timeController.text);
                                            }
                                            AppCubit.get(context)
                                                .addDose(drug: model, id: id);
                                            scheduleAlarm(timeController.text,model.name);
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
void scheduleAlarm(String dose , String title ) async {
  String day = dose.substring(dose.length-2);
  String hour = dose.split(' ')[0].split(':')[0];
  String minute = dose.split(' ')[0].split(':')[1];
  if(day == 'PM')
    hour = (int.parse(hour) + 12).toString();
  String s = hour + minute;
  if(dose.length == 7 && day != 'PM')
    s = '0' + s;
  print(s);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'Drugs App',
    'remainder_notif',
    'Channel for remainder notification',
    icon: 'drug',
    sound: RawResourceAndroidNotificationSound('notification_sound'),
    largeIcon: DrawableResourceAndroidBitmap('drug'),
  );
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
  var month = DateTime.now().month.toString();
  if(month.length == 1)
    month = '0' + month;
  day = DateTime.now().day.toString();
  if(day.length == 1)
    day = '0' + day;
  String date = DateTime.now().year.toString()+ month + day ;
  print(date);
  String dateWithT = date + 'T' + s;
  DateTime dateTime = DateTime.parse(dateWithT);
  print(dateTime);
  tz.TZDateTime time = tz.TZDateTime.from(
    dateTime,
    tz.local,
  );
  print(time);
  print(tz.TZDateTime.now(tz.local));
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'notification_sound.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    'Don\'t forget to take your medicine ${dose}',
    time,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
  );
}

