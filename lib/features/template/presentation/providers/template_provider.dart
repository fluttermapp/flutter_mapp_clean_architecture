import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/template_entity.dart';
import '../../business/usecases/get_template.dart';
import '../../data/datasources/template_local_data_source.dart';
import '../../data/datasources/template_remote_data_source.dart';
import '../../data/repositories/template_repository_impl.dart';

part 'template_provider.g.dart';

@riverpod
class Template extends _$Template {
  TemplateEntity? template;
  Failure? failure;

  @override
  ({Failure? failure, TemplateEntity? template}) build() {
    return (failure: failure, template: template);
  }

  void eitherFailureOrTemplate() async {
    TemplateRepositoryImpl repository = TemplateRepositoryImpl(
      remoteDataSource: TemplateRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrTemplate = await GetTemplate(templateRepository: repository).call(
      templateParams: TemplateParams(),
    );

    state = failureOrTemplate;
  }
}
