

class Todo{

  Todo({required this.title, required this.date});

  String title;
  String date;

  Todo.fromJson( json): title = json['title'], date = json['date'];

  toJson(){
    return {
      'title' : title,
      'date' : date
    };
  }
}