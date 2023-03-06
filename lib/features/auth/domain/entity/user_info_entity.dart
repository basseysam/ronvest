import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final String full_name;
  final String username;
  final String email;
  final String first_name;
  final String last_name;
  final dynamic avater;

  const UserInfoEntity({
    required this.full_name,
    required this.username,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avater,
});

  List<Object?> get props => [
    full_name,
    username,
    email,
    first_name,
    last_name,
    avater,
  ];

}