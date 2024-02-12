import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
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
  Future<({Failure? failure, TemplateModel? template})> getTemplate({required TemplateParams templateParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        TemplateModel remoteTemplate = await remoteDataSource.getTemplate(templateParams: templateParams);

        localDataSource.cacheTemplate(templateToCache: remoteTemplate);

        return (failure: null, template: remoteTemplate);
      } on ServerException {
        return (failure: ServerFailure(errorMessage: 'This is a server exception'), template: null);
      }
    } else {
      try {
        TemplateModel localTemplate = await localDataSource.getLastTemplate();
        return (failure: null, template: localTemplate);
      } on CacheException {
        return (failure: CacheFailure(errorMessage: 'This is a cache exception'), template: null);
      }
    }
  }
}
