import 'package:dartz/dartz.dart';

import '../../../connection/network_info.dart';
import '../../../errors/exceptions.dart';
import '../../../errors/failure.dart';
import '../../../params/params.dart';
import '../../business/repositories/template_repository.dart';
import '../datasources/template_local_data_source.dart';
import '../datasources/template_remote_data_source.dart';
import '../models/template_model.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  final TemplateRemoteDataSource remoteDataSource;
  final TemplateLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TemplateRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TemplateModel>> getTemplate(
      {required NoParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        TemplateModel remoteActivity =
            await remoteDataSource.getTemplate(params: params);

        localDataSource.cacheTemplate(remoteActivity);

        return Right(remoteActivity);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        TemplateModel localActivity = await localDataSource.getLastTemplate();
        return Right(localActivity);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
