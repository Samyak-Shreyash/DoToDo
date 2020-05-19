import 'package:form_field_validator/form_field_validator.dart';

// ignore: camel_case_types
class customValidators {
  String signInEmailError = 'Email Address not registered';
  String registerEmailError = 'Invalid Email Address';

  RequiredValidator nameValidation() {
    final nameValidator = RequiredValidator(errorText: 'Name is required');

    return nameValidator;
  }

  MultiValidator emailValidation(String formType) {
    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'Email is required'),
      EmailValidator(errorText: 'invalid email address'),
    ]);

    return emailValidator;
  }

  MultiValidator textValidation(String formType) {
    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'Field is required'),
    ]);

    return emailValidator;
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
}
