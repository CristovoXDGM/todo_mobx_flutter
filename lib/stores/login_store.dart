import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase() {
    autorun((_) {
      print("email " + email.length.toString());
      print("senha " + password.length.toString());
      print(isPasswordVisible);
    });
  }

  @observable
  bool isPasswordVisible = false;

  @action
  void setIspasswrodVisible() => isPasswordVisible = !isPasswordVisible;

  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  @observable
  bool isLoading = false;

  @action
  Future<void> login() async {
    isLoading = true;
    //processar dados
    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
  }

  @computed
  bool get isFormValid => email.length >= 6 && password.length >= 6;

  @computed
  bool get isPasswordValid => password.length > 6;
}
