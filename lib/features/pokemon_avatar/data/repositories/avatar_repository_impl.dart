import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/avatar_repository.dart';
import '../datasources/avatar_local_data_source.dart';
import '../datasources/avatar_remote_data_source.dart';
import '../models/avatar_image_model.dart';

class AvatarImageRepositoryImpl implements AvatarRepository {
  final AvatarImageRemoteDataSource remoteDataSource;
  final AvatarImageLocalDataSourceImpl localDataSource;
  final NetworkInfo networkInfo;

  AvatarImageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AvatarImageModel>> getAvatar(
      {required PokemonAvatarParams avatarParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTemplate =
            await remoteDataSource.getAvatarImage(avatarImageParams: avatarParams);

        localDataSource.cacheAvatarImage(avatarImageToCache: remoteTemplate);

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getLastAvatarImage();
        return Right(localTemplate);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
