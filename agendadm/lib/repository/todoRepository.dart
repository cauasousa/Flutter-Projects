import 'dart:convert';

import 'package:agendadm/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keyTodo = 'todos';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();

    final String todoJson = sharedPreferences.getString(keyTodo) ?? '[]';
    final List listTodo = json.decode(todoJson) as List;
    return listTodo.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos) async{
    // sharedPreferences.
    String jsonString = json.encode(todos);
    

    sharedPreferences.setString(keyTodo, jsonString);
  }
}
