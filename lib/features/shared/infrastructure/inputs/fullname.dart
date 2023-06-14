import 'package:formz/formz.dart';

// Define input validation errors
enum FullNameError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class FullName extends FormzInput<String, FullNameError> {


  static final RegExp fullnameRegExp = RegExp(
    r'(^[A-Za-z]{3,16})([ ]{0,1})([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})',
  );

  // Call super.pure to represent an unmodified form input.
  const FullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const FullName.dirty( String value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == FullNameError.empty ) return 'This is a required field';
    if ( displayError == FullNameError.length ) return '6 caracters minimum';
    if ( displayError == FullNameError.format ) return 'It must contain a full name';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  FullNameError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return FullNameError.empty;
    if ( value.length < 6 ) return FullNameError.length;
    if ( !fullnameRegExp.hasMatch(value)) return FullNameError.format;

    return null;
  }
}