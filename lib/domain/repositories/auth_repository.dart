import 'package:dartz/dartz.dart';
import 'package:shartflix/core/error/failure.dart';
import 'package:shartflix/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(String email, String password);
  Future<Either<Failure, void>> register(String email, String password, String fullName);

}
