const String idContact = "idContact";
const String nameContact = "nameContact";
const String emailContact = "emailContact";
const String numberContact = "numberContact";
const String imgContact = "imgContact";


class Contact {

  int? id;
  String name = '';
  String email = "";
  String number = "";
  String img = '';
  Contact();

  
  Contact.fromMap(Map map){
    id = map[idContact];
    name = map[nameContact];
    email = map[emailContact];
    number = map[numberContact];
    img = map[imgContact];
  }

  Map<String, dynamic> toMap(){

    Map <String, dynamic> map = {
      nameContact: name,
      emailContact: email,
      numberContact: number,
      imgContact: img ,
    };

    // ignore: unnecessary_null_comparison
    if(id != null){
      map[idContact] = id;
    }

    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id: $id, name:$name, img:$img";
  }
}