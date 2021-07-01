import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';

class ProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getDrugs();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is !GetDrugsLoadingState && state is !GetUserLoadingState,
          builder:(context) => SingleChildScrollView(child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    )),
                height: 200,
                width: double.infinity,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 90.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  AppCubit.get(context).userModel.image),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppCubit.get(context).userModel.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                                ),
                                Text('Cairo'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(35.0),
                      elevation: 3,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          color: Colors.lightGreen,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            showBottomSheet(
                              context: context,
                              builder: (context) => Material(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25),
                                ),
                                elevation: 35.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                      )),
                                  height: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        defaultTextField(
                                          controller: nameController,
                                          label: 'Drug Name',
                                          prefix:
                                          Icons.medical_services_outlined,
                                          type: TextInputType.name,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        defaultButton(
                                            text: 'ADD',
                                            function: () {
                                              if(nameController.text != '')
                                              {
                                                AppCubit.get(context).addDrug(
                                                    name: nameController.text);
                                                nameController.clear();
                                                AppCubit.get(context).getDrugs();
                                                Navigator.pop(context);
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Add Drug'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ConditionalBuilder(
                    condition: AppCubit.get(context).drugs.length != 0,
                    builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => drugCard(
                          context, AppCubit.get(context).drugs[index],
                          AppCubit.get(context).drugsID[index],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5.0,
                        ),
                        itemCount: AppCubit.get(context).drugs.length),
                    fallback: (context) => Column(
                      children:[
                        SizedBox(height: 20.0,),
                        Image(image: AssetImage('assets/images/add.png'),),
                        Text('There is no Drugs yet!',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),),
                        Text('Add some',style: TextStyle(fontSize: 18.0,color:kPrimary,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
          fallback:(context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
