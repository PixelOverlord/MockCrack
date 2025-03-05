import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String username;
  final String occupation;
  final List<String> interviews;
  final num score;
  final List<String> techStack;
  final List<String> preferences;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.username,
    required this.occupation,
    required this.interviews,
    required this.score,
    required this.techStack,
    required this.preferences,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        username,
        occupation,
        interviews,
        score,
        techStack,
        preferences,
      ];
}
