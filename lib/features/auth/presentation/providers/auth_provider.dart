
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/domain/repositories/auth_repository.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastructure/repositories/auth_repository_impl.dart';


final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(
    authRepository: authRepository
  ); 
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  
  AuthNotifier({
    required this.authRepository
  }): super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('error not controled');
    }
    // await authRepository.login(email, password);
    // state = state.copywith(user: user, )
  }

  void registerUser(String email, String password) async {
    
  }

  void checkAuthStatus() async {
    
  }

  void _setLoggedUser(User user) {
    state = state.copywith(
      user: user,
      authStatus: AuthStatus.autheticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async{
    state = state.copywith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }
}


enum AuthStatus {checking, autheticated, notAuthenticated}

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
  });

  AuthState copywith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );
}