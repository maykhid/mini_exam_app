///Checks if a String input is a valid email format
isTextEmail(String text) => Validators.isEmail(text);

///Checks if a String input is conains only numbers
isTextNumeric(String text) => Validators.isNumeric(text);

class Validators {
  static isEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  static isNumeric(String name) => name.contains(RegExp(r'[a-zA-Z]'));
}
