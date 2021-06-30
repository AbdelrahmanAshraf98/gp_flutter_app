import 'package:gp_flutter_app/layout/cubit/cubit.dart';
import 'package:gp_flutter_app/shared/components/components.dart';
import 'package:intl/intl.dart';

class DrugModel {
  String name;
  String text;
  String image;
  List<dynamic> dose;

  DrugModel(
      this.name,
      this.text,
      this.image,
      this.dose
      );

  DrugModel.fromJson(Map<String,dynamic>json){
    text = json['text'];
    image = json['image'];
    name = json['name'];
    dose = json['dose'];
    print(dose);
    dose.sort((a, b) => parseTime(a).compareTo(parseTime(b)));
    print(dose);
  }

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
      'text' : text,
      'image':image,
      'doses':dose,
    };
  }
}