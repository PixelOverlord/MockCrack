part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String uid;
  const Authenticated(this.uid);
  @override
  List<Object> get props => [uid];
}

class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
  @override
  List<Object> get props => [message];
}
