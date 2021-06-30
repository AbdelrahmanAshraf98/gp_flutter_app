class DoseModel {
  String  time;


 DoseModel(
      this.time,
      );

  DoseModel.fromJson(Map<String,dynamic>json){
    time = json['time'];
  }

  Map<String,dynamic> toMap(){
    return{
      'time' : time,
    };
  }
}