class Validator {
  static String? validateEmail(String? value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (value == null || value.isEmpty) {
      return '🚩 Please provide your email address.';
    } else if (!regex.hasMatch(value)) {
      return '🚩 Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '🚩 Please provide your password';
    } else if (value.length < 8) {
      return '🚩 Password must not be less than 8 chracters';
    } else {
      return null;
    }
  }

  static String? fullNameValidate(String? fullName) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);
    if (fullName == null || fullName.isEmpty) {
      return '🚩 Please provide your full name';
    } else if (!regExp.hasMatch(fullName)) {
      return '🚩 Please enter valid full name';
    }
    return null;
  }
}
