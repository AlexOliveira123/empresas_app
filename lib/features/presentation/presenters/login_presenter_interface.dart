abstract class ILoginPresenter {
  abstract String email;
  abstract String password;
  String? errorText;
  void setEmail(String value);
  void setPassword(String value);
  void setErrorText(String? value);
  Future<bool> doLogin();
}
