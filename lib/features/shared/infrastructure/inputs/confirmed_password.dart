import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

// Define input validation errors
enum ConfirmedpasswordError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Confirmedpassword extends FormzInput<String, ConfirmedpasswordError> {

  // Call super.pure to represent an unmodified form input.
  const Confirmedpassword.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Confirmedpassword.dirty( String value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ConfirmedpasswordError.empty ) return 'This field is required';
    if ( displayError == ConfirmedpasswordError.length ) return 'Please make sure your passwords match';
    if ( displayError == ConfirmedpasswordError.format ) return 'Please make sure your passwords match';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  ConfirmedpasswordError? validator(String value,) {

    final password = Password.dirty(value);
    final confirmedpassword = Confirmedpassword.dirty(value);

    if ( value.isEmpty || value.trim().isEmpty ) return ConfirmedpasswordError.empty;
    if ( value.length < 6 ) return ConfirmedpasswordError.length;
    if ( password.value != confirmedpassword.value ) return ConfirmedpasswordError.format;

    return null;
  }
}