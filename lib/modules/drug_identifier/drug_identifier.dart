import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/layout/cubit/states.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:gp_flutter_app/shared/components/constants.dart';

class DrugIdentifier extends StatelessWidget {
  var imprintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextField(
                    controller: imprintController,
                    type: TextInputType.text,
                    label: 'imprint',
                    prefix: Icons.search,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Pick pill color',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Spacer(),
                      DropdownButton<String>(
                          value: AppCubit.get(context).color,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String newValue) {
                            AppCubit.get(context).changeColor(newValue);
                          },
                          items: [
                            DropdownMenuItem(
                                value: 'red',
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 15.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text('red'),
                                  ],
                                )),
                            DropdownMenuItem(
                              value: 'yellow',
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    radius: 15.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('Yellow'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'blue',
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 15.0,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('Blue'),
                                ],
                              ),
                            ),
                          ])
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Pick pill shape',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Spacer(),
                      DropdownButton<String>(
                          value: AppCubit.get(context).shape,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String newValue) {
                            AppCubit.get(context).changeShape(newValue);
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'square',
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/square.png',
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('square'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'round',
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/oval.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('round'),
                                ],
                              ),
                            ),
                          ])
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    text: 'Search',
                    function: () {
                      AppCubit.get(context).getPill(
                        color: AppCubit.get(context).color,
                        imprint: imprintController.text,
                        shape: AppCubit.get(context).shape,
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if(state is GetPillLoadingState)
                    LinearProgressIndicator(),
                  ConditionalBuilder(
                    condition: AppCubit.get(context).results.length == 0,
                    builder: (context) => Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Image.asset('assets/images/search.png'),
                        Text(
                          'No results yet',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          'Search Now!',
                          style: TextStyle(
                              color: kPrimary,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    fallback: (context) => GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: AppCubit.get(context).results.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 1,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 20),
                      itemBuilder: (context, index) => Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Image(
                              image: NetworkImage(
                                  AppCubit.get(context).results[index].image),
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                AppCubit.get(context).results[index].name,
                                style: TextStyle(color: Colors.white)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
