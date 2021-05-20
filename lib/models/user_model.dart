class UserModel {
  String name;
  String email;
  String age;
  String userID;
  String image;


  UserModel({
    this.name,
    this.email,
    this.userID,
    this.image,
    this.age,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userID = json['uID'];
    image = json['image'];
    age = json['age'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'uID': userID,
      'image':image,
    };
  }
}