import 'package:dartz/dartz.dart';
import 'package:shartflix/core/error/failure.dart';
import 'package:shartflix/domain/entities/login_entity.dart';
import 'package:shartflix/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, LoginEntity>> call(LoginRequest request) {
    return repository.login(request.email, request.password);
  }
}

class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});
}
