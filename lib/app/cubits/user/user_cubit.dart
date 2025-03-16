import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mockcrack/domain/entities/users_entity.dart';
import 'package:mockcrack/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/get_user_stream_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/update_user_interviews_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/update_user_preferences_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/update_user_profile_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/update_user_score_usecase.dart';
import 'package:mockcrack/domain/usecases/auth/update_user_tech_stack_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final GetUserStreamUseCase getUserStreamUseCase;
  final UpdateUserInterviewsUseCase updateUserInterviewsUseCase;
  final UpdateUserPreferencesUseCase updateUserPreferencesUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final UpdateUserScoreUseCase updateUserScoreUseCase;
  final UpdateUserTechStackUseCase updateUserTechStackUseCase;

  UserCubit({
    required this.getUserStreamUseCase,
    required this.updateUserInterviewsUseCase,
    required this.updateUserPreferencesUseCase,
    required this.updateUserProfileUseCase,
    required this.updateUserScoreUseCase,
    required this.updateUserTechStackUseCase,
    required this.getCurrentUidUseCase,
  }) : super(UserInitial());

  Future<void> getUser({required UserEntity user}) async {
    emit(UserLoading());

    try {
      final uid = await getCurrentUidUseCase.call();
      final streamRes = getUserStreamUseCase.call(uid!);

      streamRes.listen((users) => emit(UserLoaded(user: users!)));
    } on SocketException catch (e) {
      emit(UserError(message: e.toString()));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateUserInterviews(
      {required UserEntity user, required List<String> interviews}) async {
    emit(UserLoading());

    try {
      final uid = await getCurrentUidUseCase.call();
      await updateUserInterviewsUseCase.call(uid!, interviews);
    } on SocketException catch (e) {
      emit(UserError(message: e.toString()));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateUserPreferences(
      {required UserEntity user, required List<String> preferences}) async {
    emit(UserLoading());

    try {
      final uid = await getCurrentUidUseCase.call();
      await updateUserPreferencesUseCase.call(uid!, preferences);
    } on SocketException catch (e) {
      emit(UserError(message: e.toString()));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateUserScore(
      {required UserEntity user, required num score}) async {
    emit(UserLoading());

    try {
      final uid = await getCurrentUidUseCase.call();
      await updateUserScoreUseCase.call(uid!, score);
    } on SocketException catch (e) {
      emit(UserError(message: e.toString()));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateUserTechStack(
      {required UserEntity user, required List<String> techStack}) async {
    emit(UserLoading());

    try {
      final uid = await getCurrentUidUseCase.call();
      await updateUserTechStackUseCase.call(uid!, techStack);
    } on SocketException catch (e) {
      emit(UserError(message: e.toString()));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> updateUserProfile({required UserEntity user}) async {
    emit(UserLoading());

    try {
      await updateUserProfileUseCase.call(user);
    } on SocketException catch (e) {
      emit(UserError(message: e.toString()));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
