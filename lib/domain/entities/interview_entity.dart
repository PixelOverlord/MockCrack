import 'package:equatable/equatable.dart';

class InterviewEntity extends Equatable {
  final String interviewId;
  final String userId;
  final String role;
  final String level;
  final List<String> techStacks;
  final String score;
  final List<String> questions;
  final List<String> answers;
  final DateTime duration;
  final DateTime createdAt;

  InterviewEntity({
    required this.interviewId,
    required this.userId,
    required this.role,
    required this.level,
    required this.techStacks,
    required this.score,
    required this.questions,
    required this.answers,
    required this.duration,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        interviewId,
        userId,
        role,
        level,
        techStacks,
        score,
        questions,
        answers,
        duration,
        createdAt,
      ];
}
