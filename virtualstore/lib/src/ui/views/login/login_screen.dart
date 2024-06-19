import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtualstore/src/controllers/user.dart';
import 'package:virtualstore/src/ui/views/cadastrar/cadastrar_screen.dart';
import 'package:virtualstore/src/ui/views/recover_pass/pageRecoverPass.dart';
import 'package:virtualstore/src/ui/views/widget/widget_text_field.dart';
import 'package:virtualstore/src/ui/views/widget/CustomElevatedButton.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller_email = TextEditingController();

  final TextEditingController _controller_password = TextEditingController();

  bool testActivebtt = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Users>(
      builder: (context, child, model) {
        onpressed() async {
          if (!_formkey.currentState!.validate()) {
            return;
          } else {
            FocusScope.of(context).unfocus();

            model.signIn(
              email: _controller_email.text,
              password: _controller_password.text,
              onSucess: onSucess,
              onFail: onFail,
            );

          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Entrar",
              style: TextStyle(fontSize: 17),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CadastrarScreen(),
                )),
                child: Text(
                  "CRIAR CONTA",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          body: model.isloading
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        WidgetTextField(
                          text: "E-mail",
                          controller: _controller_email,
                          stateOnChanged: test,
                          emailbool: true,
                        ),
                        Padding(padding: EdgeInsets.all(12.0)),
                        WidgetTextField(
                          text: "Senha",
                          textBool: false,
                          controller: _controller_password,
                          stateOnChanged: test,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PageRecoverPass(),
                                  ),
                                );
                              },
                              child: Text(
                                "Esqueci minha senha",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 4.0)),
                                alignment: Alignment.topRight,
                                overlayColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                              ),
                            ),
                          ],
                        ),
                        CustomElevatedButton(
                          text: 'Entrar',
                          active: test(),
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

  bool test() {
    if (_controller_email.text != '' && _controller_password.text != '') {
      if (!testActivebtt) {
        setState(() {
          testActivebtt = true;
        });
      }
    } else {
      if (testActivebtt) {
        setState(() {
          testActivebtt = false;
        });
      }
    }

    return testActivebtt;
  }

  onSucess() {
    Navigator.pop(context);
  }

  void onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Falha ao entrar!"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
