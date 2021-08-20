import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message});

  @override
  List<Object?> get props => <Object>[message];
}

class ServerFailure extends Failure {
  ServerFailure({message}) : super(message: message);

  @override
  List<Object?> get props => List.empty();
}

class InvalidCredentialsFailure extends Failure {
  InvalidCredentialsFailure({message}) : super(message: message);

  @override
  List<Object?> get props => <Object>[message];
}
