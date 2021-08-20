class Validators {
  static bool isValidEmail(String email) {
    return RegExp(
                r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email) &&
        !blockEmoji().hasMatch(email);
  }

  static bool isValidPassword(String password) =>
      password.isEmpty ? true : password.trim().length >= 4;

  static RegExp blockEmoji() {
    return RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
  }
}
