part of 'creds_cubit.dart';

abstract class CredsState extends Equatable {
  const CredsState();
}

class CredsInitial extends CredsState {
  @override
  List<Object> get props => [];
}

class CredsLoading extends CredsState {
  @override
  List<Object> get props => [];
}

class CredsLoaded extends CredsState {
  @override
  List<Object> get props => [];
}

class CredsError extends CredsState {
  final String message;
  const CredsError({required this.message});
  @override
  List<Object> get props => [message];
}
