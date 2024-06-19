import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/ui/views/widget/CustomElevatedButton.dart';
import 'package:virtualstore/src/ui/views/widget/widget_text_field.dart';

class CadastrarScreen extends StatefulWidget {
  CadastrarScreen({super.key});

  @override
  State<CadastrarScreen> createState() => _CadastrarScreenState();
}

class _CadastrarScreenState extends State<CadastrarScreen> {
  final TextEditingController _controller_name = TextEditingController();

  final TextEditingController _controller_password = TextEditingController();

  final TextEditingController _controller_email = TextEditingController();

  final TextEditingController _controller_adress = TextEditingController();

  final _formkey = GlobalKey<FormState>();


  bool testActivBtt = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Users>(
      builder: (context, child, model) {
        onpressed() {
          if (!_formkey.currentState!.validate()) {
            setState(() {
              testActivBtt = false;
            });
          } else {
            FocusScope.of(context).unfocus();

            Map<String, dynamic> userData = {
              "email": _controller_email.text,
              "address": _controller_adress.text,
              "password": _controller_password.text,
              "name": _controller_name.text,
            };

            model.signUp(
              userData: userData,
              pass: _controller_password.text,
              onSucess: onSucess,
              onFail: onFail,
            );

          }
        }

      
        return Scaffold(
         
          appBar: AppBar(
            title: Text(
              "Criar Conta",
              style: TextStyle(fontSize: 17),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(14.0),
              child: Column(
                children: [
                  WidgetTextField(
                      text: 'Nome Completo',
                      controller: _controller_name,
                      stateOnChanged: bttTest),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  WidgetTextField(
                    text: 'E-mail',
                    controller: _controller_email,
                    stateOnChanged: bttTest,
                    emailbool: true,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  WidgetTextField(
                    text: 'Senha',
                    controller: _controller_password,
                    stateOnChanged: bttTest,
                    textBool: false,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  WidgetTextField(
                    text: 'Endereço',
                    controller: _controller_adress,
                    stateOnChanged: bttTest,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  CustomElevatedButton(
                    text: 'Criar Conta',
                    active: bttTest(),
                    onpressed: onpressed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future onSucess() async{
    print("SUCESS");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Conta criada com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );

    await Future.delayed(Duration(seconds: 2)).then(
      (value) => Navigator.pop(context),
    );

  }

  onFail() {
    print("Fail");
    ScaffoldMessenger.of(context).showSnackBar(
      
      SnackBar(
        content: Text("Não foi possível criar conta."),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        
      ),
    );

  }

  bool bttTest() {
    if (_controller_name.text.isNotEmpty &&
        _controller_email.text.isNotEmpty &&
        _controller_password.text.isNotEmpty &&
        _controller_adress.text.isNotEmpty) {
      if (!testActivBtt) {
        setState(() {
          testActivBtt = true;
        });
      }
    } else {
      if (testActivBtt) {
        setState(() {
          testActivBtt = false;
        });
      }
    }

    return testActivBtt;
  }
}
