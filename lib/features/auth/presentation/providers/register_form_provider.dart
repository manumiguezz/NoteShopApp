

import 'package:noteshop/features/shared/infrastructure/inputs/inputs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class RegisterFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final FullName fullName;
  final Confirmedpassword confirmedpassword;

  RegisterFormState({
    this.isPosting = false, 
    this.isFormPosted = false, 
    this.isValid = false, 
    this.email = const Email.pure(), 
    this.password = const Password.pure(), 
    this.fullName = const FullName.pure(),
    this.confirmedpassword = const Confirmedpassword.pure(),
  });

  

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    FullName? fullName,
    Confirmedpassword? confirmedpassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
    fullName: fullName ?? this.fullName,
    confirmedpassword: confirmedpassword ?? this.confirmedpassword,
  );


  @override 
  String toString() {
    return '''
    RegisterFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
    fullName: $fullName
    confirmedpassword: $confirmedpassword
''';
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier(): super(RegisterFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password, state.fullName, state.confirmedpassword])
    );
  }
  
  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email, state.fullName, state.confirmedpassword])
    );
  }

  onFullNameChanged(String value) {
    final newFullname = FullName.dirty(value);
    state = state.copyWith(
      fullName: newFullname,
      isValid: Formz.validate([newFullname, state.email, state.password, state.confirmedpassword])
    );
  }

  onConfirmedpasswordChanged(String value) {
    final newConfirmedpassword = Confirmedpassword.dirty(value);
    state = state.copyWith(
      confirmedpassword: newConfirmedpassword,
      isValid: Formz.validate([newConfirmedpassword, state.email, state.password, state.fullName])
    );
  }

  onFormSubmit() {
    _touchEveryField();

    if(!state.isValid) return;

    }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final fullname = FullName.dirty(state.fullName.value);
    final confirmedpassword = Confirmedpassword.dirty(state.confirmedpassword.value);
    
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      fullName: fullname,
      confirmedpassword: confirmedpassword,
      isValid: Formz.validate([email, password, fullname, confirmedpassword])
    );
  }
}

  final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
    return RegisterFormNotifier();
  });
  