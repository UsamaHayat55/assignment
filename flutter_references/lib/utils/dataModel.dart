
class DataModel{

  late dynamic? id;
  late String? name, age, imgUrl;

  DataModel({this.id, this.name, this.age, this.imgUrl});

//  DataModel({required this.name, required this.age});

  // Convert a DataModel object into a Map object
  Map<String, dynamic> toMap(){
    return{
      'id': id ?? null,
      'name': name ?? "",
      'age': age ?? "",
      'imgUrl': imgUrl ?? "",
    };
  }

  // Convert a Map object into a DataModel object
  factory DataModel.fromMap(Map<dynamic, dynamic> map) {
    return DataModel(
      id: map['id'] ?? null,
      name: map['name'] ?? "",
      age: map['age'] ?? "",
      imgUrl: map['imgUrl'] ?? "",
    );
  }

}