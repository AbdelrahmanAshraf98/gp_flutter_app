class DrugModel {
  String name;
  String text;
  String image;

  DrugModel(
      this.name,
      this.text,
      this.image,
      );

  DrugModel.fromJson(Map<String,dynamic>json){
    text = json['text'];
    image = json['image'];
    name = json['name'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
      'text' : text,
      'image':image,
    };
  }
}