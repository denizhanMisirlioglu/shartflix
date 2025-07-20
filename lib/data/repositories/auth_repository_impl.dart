import 'package:dartz/dartz.dart';
import 'package:shartflix/core/error/exception.dart';
import 'package:shartflix/core/error/failure.dart';
import 'package:shartflix/domain/entities/login_entity.dart';
import 'package:shartflix/domain/repositories/auth_repository.dart';

import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login(String email, String password) async {
    try {
      final model = await remoteDataSource.login(email, password);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register(String email, String password, String fullName) async {
    try {
      await remoteDataSource.register(email, password, fullName);
      return const Right(null); // boş başarı
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
