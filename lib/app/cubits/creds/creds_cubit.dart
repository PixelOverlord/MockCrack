import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockcrack/domain/entities/users_entity.dart';
import 'package:mockcrack/domain/usecases/auth/sign_in_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_out_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/sign_up_usecase.dart';

part 'creds_state.dart';

class CredsCubit extends Cubit<CredsState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  CredsCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(CredsInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(CredsLoading());
    try {
      await signInUseCase.call(email, password);
      emit(CredsLoaded());
    } catch (e) {
      emit(CredsError(message: e.toString()));
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required UserEntity user}) async {
    emit(CredsLoading());
    try {
      await signUpUseCase.call(email, password, user);
      emit(CredsLoaded());
    } on SocketException {
      emit(const CredsError(message: 'No Internet Connection'));
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        emit(const CredsError(message: 'User Already Exist'));
      } else if (err.code == 'weak-password') {
        emit(const CredsError(message: 'Password is Weak'));
      }
    }
  }
}
