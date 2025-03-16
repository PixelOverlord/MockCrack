import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mockcrack/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/get_signed_in_status_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final GetSignedInStatusUseCase getSignedInStatusUseCase;
  final SignOutUseCase signOutUseCase;
  AuthCubit({
    required this.getCurrentUidUseCase,
    required this.getSignedInStatusUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignin = await getSignedInStatusUseCase.call();

      if (isSignin) {
        final uid = await getCurrentUidUseCase.call();

        emit(Authenticated(uid!));
      } else {
        emit(Unauthenticated());
      }
    } on SocketException catch (e) {
      emit(AuthError(message: "No Internet"));
    } catch (e) {
      emit(AuthError(message: "Something Went Wrong"));
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid!));
    } on SocketException catch (e) {
      emit(AuthError(message: "No Internet"));
    } catch (e) {
      emit(AuthError(message: "Something Went Wrong"));
    }
  }

  Future<void> logout() async {
    try {
      await signOutUseCase.call();
      emit(Unauthenticated());
    } on SocketException catch (e) {
      emit(AuthError(message: "No Internet"));
    } catch (e) {
      emit(AuthError(message: "Something Went Wrong"));
    }
  }
}
