import 'package:mockcrack/domain/entities/users_entity.dart';

class UserModel extends UserEntity {
  final String uid;
  final String email;
  final String username;
  final String occupation;
  final List<String> interviews;
  final num score;
  final List<String> techStack;
  final List<String> preferences;

  const UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.occupation,
    required this.interviews,
    required this.score,
    required this.techStack,
    required this.preferences,
  }) : super(
          uid: uid,
          email: email,
          username: username,
          occupation: occupation,
          interviews: interviews,
          score: score,
          techStack: techStack,
          preferences: preferences,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      occupation: map['occupation'],
      interviews: map['interviews'],
      score: map['score'],
      techStack: map['techStack'],
      preferences: map['preferences'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'occupation': occupation,
      'interviews': interviews,
      'score': score,
      'techStack': techStack,
      'preferences': preferences,
    };
  }
}
