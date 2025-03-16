import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? username;
  final String? occupation;
  final List? interviews;
  final num? score;
  final List? techStack;
  final List? preferences;

  const UserEntity({
    this.uid,
    this.email,
    this.username,
    this.occupation,
    this.interviews,
    this.score,
    this.techStack,
    this.preferences,
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
