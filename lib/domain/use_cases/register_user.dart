import 'package:dartz/dartz.dart';
import 'package:shartflix/core/error/failure.dart';
import 'package:shartflix/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, void>> call(RegisterRequest request) {
    return repository.register(
      request.email,
      request.password,
      request.fullName,
    );
  }
}

class RegisterRequest {
  final String email;
  final String password;
  final String fullName;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.fullName,
  });
}
