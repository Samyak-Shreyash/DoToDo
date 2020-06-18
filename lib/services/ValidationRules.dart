import 'dart:convert';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class customValidators {
  Future<void> checkEmail(email) async {
    try {
      Response response = await get(
          'https://us.central1-dotodo-web.cloudfunctions.net/app');
      Map data = jsonDecode(response.body);
      print(data);
    }
    catch (e) {
      print('Caught Error: $e');
    }
  }


  MultiValidator emailValidation(String formType) {
    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'Field is required'),
      EmailValidator(errorText: 'Not an email Address')
    ]);

    return emailValidator;
}


  MultiValidator textValidation(String formType) {
    final textValidator = MultiValidator([
      RequiredValidator(errorText: 'Field is required'),
    ]);

    return textValidator;
  }

  MultiValidator passwordValidation() {
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 digits long'),
    ]);

    return passwordValidator;
  }

  String matchPassword(val, password) {
    final matchPassword = MatchValidator(errorText: 'passwords do not match')
        .validateMatch(val, password);
    return matchPassword;
}


  bool requiredValidator(val) {
    return val.isEmpty;
}


}




