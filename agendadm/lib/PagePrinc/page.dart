import 'package:agendadm/AdditemPage/addPage.dart';
import 'package:agendadm/item/todolist.dart';
import 'package:agendadm/models/todo.dart';
import 'package:agendadm/repository/todoRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TodoRepository todoreposiy = TodoRepository();

  List<Todo> todos = [];

  final TextEditingController textvalue = TextEditingController();
  Todo? removido;
  int? indexRemov;
  String textError = '';
  bool showErrorBool = false;
  // final List<Todo> todos = await todoreposiy.getTodoList();
  @override
  void initState() {
    super.initState();

    todoreposiy.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lista de Tarefas',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.all(12.0)),
              AddItem(
                  textvalue: textvalue,
                  additem: additem,
                  alterarShow: alterarShow),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  textError,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Todo todo in todos)
                      TodoListItem(todo: todo, onDelete: onDelete),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    // const Padding(padding: EdgeInsets.all(5.0)),

                    ElevatedButton(
                      onPressed: showDeleteEvery,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 112, 210, 248),
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        shadowColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'Limpar Tudo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void additem() {
    Todo addtodo = Todo(
      title: textvalue.text.toString(),
      date: DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.now()),
    );

    setState(() {
      todos.add(addtodo);
    });

    todoreposiy.saveTodoList(todos);

    textvalue.clear();
  }

  void onDelete(Todo todo) {
    removido = todo;
    indexRemov = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoreposiy.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Foi removido com sucesso!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color.fromARGB(255, 112, 210, 248),
          onPressed: desfazer,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void desfazer() {
    setState(() {
      todos.insertAll(indexRemov!, [removido!]);
    });
    todoreposiy.saveTodoList(todos);
  }

  void showDeleteEvery() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apagar Tudo?'),
        content: Text('Você tem certeza que deseja apagar tudo? '),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: const Color.fromARGB(255, 112, 210, 248),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteTodos();
            },
            child: Text(
              "Limpar Tudo",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 2, 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteTodos() {
    setState(() {
      todos.clear();
    });
    todoreposiy.saveTodoList(todos);
  }

  void alterarShow(bool stateerror) {
    setState(() {
      showErrorBool = stateerror;
      showError();
    });
  }

  void showError() {
    if (showErrorBool) {
      textError = '*Preencha o título!';
    } else {
      textError = '';
    }
  }

  double tamwidget() {
    return larguradispositivo() * 0.85;
  }

  double tamadd() {
    return larguradispositivo() * 0.15;
  }

  double tamlimpar() {
    return larguradispositivo() * 0.25;
  }

  double larguradispositivo() {
    return MediaQuery.of(context).size.width;
  }
}
