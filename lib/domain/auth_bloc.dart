import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/mock_data.dart';

// States for AuthBloc
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
  
  @override
  List<Object> get props => [message];
}

// Events for AuthBloc
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String emailOrPhone;
  final String password;
  final bool isPhoneLogin;

  const LoginEvent(this.emailOrPhone, this.password, this.isPhoneLogin);

  @override
  List<Object> get props => [emailOrPhone, password, isPhoneLogin];
}

// AuthBloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial())
  {
    // Register the event handler here
    on<LoginEvent>(_onLoginEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Simulate login logic using mock data
    final user = users.firstWhere(
      (user) =>
          (event.isPhoneLogin ? user['phone'] : user['email']) == event.emailOrPhone &&
          user['password'] == event.password,
      orElse: () => {},
    );

    if (user != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthError("Invalid login credentials."));
    }
  }
}

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield AuthLoading();

      // Simulate login logic using mock data
      final Map<String, String>? user = users.firstWhere(
        (user) =>
            (event.isPhoneLogin ? user['phone'] : user['email']) == event.emailOrPhone &&
            user['password'] == event.password,
        orElse: () => {},
      );

      if (user != null) {
        yield AuthAuthenticated();
      } else {
        yield const AuthError("Invalid login credentials.");
      }
    }
  }

