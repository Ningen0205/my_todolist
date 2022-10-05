import 'package:email_validator/email_validator.dart';

enum Charset { upperAlphabet, lowerAlphabet, specialCharcter, number }

class Validators {
  static String? Function(String? value) mixin(
      {required List<String? Function(String? value)> validators}) {
    validation(String? value) {
      for (var validator in validators) {
        String? errorText = validator(value);

        if (errorText == null) continue;

        return errorText;
      }
    }

    return validation;
  }

  static String? Function(String? value) minLength(
      {required int min, String? customErrorMessage}) {
    String errorMessage = customErrorMessage ?? "$min文字以上で入力してください。";

    validation(String? value) {
      if (value == null || value.length < min) {
        return errorMessage;
      } else {
        return null;
      }
    }

    return validation;
  }

  static String? Function(String? value) exists(
      {required List<Charset> charSets, required String errorText}) {
    validation(String? value) {
      for (var validCharSet in charSets) {
        RegExp regExp;

        switch (validCharSet) {
          case Charset.lowerAlphabet:
            regExp = RegExp(r'(?=.*?[a-z])');
            break;
          case Charset.upperAlphabet:
            regExp = RegExp(r'(?=.*?[A-Z])');
            break;
          case Charset.number:
            regExp = RegExp(r'(?=.*?[0-9])');
            break;
          case Charset.specialCharcter:
            regExp = RegExp(r'(?=.*?[!@#\$&*~])');
            break;
        }

        if (value == null || !regExp.hasMatch(value)) {
          return errorText;
        }
      }
    }

    return validation;
  }

  static String? Function(String? value) email({
    String? customErrorMessage,
  }) {
    String errorMessage = customErrorMessage ?? "有効なメールアドレスではありません。";

    validation(String? value) {
      if (value == null) return errorMessage;

      return EmailValidator.validate(value) ? null : errorMessage;
    }

    return validation;
  }
}
