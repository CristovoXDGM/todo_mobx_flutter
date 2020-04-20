import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();
  // o disposer tem como seu principal objetivo evitar o armazenamento desencessário de dados na memória, fazendo com que o processo não fique executando em um loop eterno
  ReactionDisposer disposer;

  //Conhecido como reactios no Mobx, são as reações de acordo com as funões e metodos
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // o disposer recebe a reaction para poder limpar a memória posteriormente ao mudar/avançar de tela
    disposer = reaction((_) => loginStore.loggedIn, (loggedIn) {
      if (loginStore.loggedIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ListScreen()));
      }
    });
    //Pode ser utilizado também ao invés da própria função reaction, em maioria dos casos ele é utilizado, sendo assim a função reaction pouco utilizada; (OBS: ambos são reactions)
    // autorun((_) {
    //   //login implementado utilizando o mobx
    //   print(loginStore.loggedIn);
    //   if (loginStore.loggedIn) {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => ListScreen()));
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'E-mail',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                        enabled: !loginStore.isLoading,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: Icon(Icons.lock),
                        obscure: !loginStore.isPasswordVisible,
                        onChanged: loginStore.setPassword,
                        enabled: !loginStore.isLoading,
                        suffix: CustomIconButton(
                            radius: 32,
                            iconData: Icons.visibility,
                            onTap: loginStore.setIspasswrodVisible),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: Observer(builder: (_) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: !loginStore.isLoading
                              ? Text('Entrar')
                              : CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: loginStore.isFormValid
                              ? loginStore.loginPressed
                              : null,
                        );
                      }),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    disposer();
  }
}
