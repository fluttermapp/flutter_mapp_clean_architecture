import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/template/business/entities/template_entity.dart';
import '../../../../core/template/business/usecases/get_template.dart';
import '../../../../core/template/data/datasources/template_local_data_source.dart';
import '../../../../core/template/data/datasources/template_remote_data_source.dart';
import '../../../../core/template/data/repositories/template_repository_impl.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemplateProvider extends ChangeNotifier {
  TemplateEntity? template;
  Failure? failure;

  TemplateProvider({
    this.template,
    this.failure,
  });

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

    final failureOrActivity = await GetTemplate(repository).call(
      params: NoParams(),
    );

    failureOrActivity.fold(
      (Failure newFailure) {
        template = null;
        failure = newFailure;
        notifyListeners();
      },
      (TemplateEntity newTemplate) {
        template = newTemplate;
        failure = null;
        notifyListeners();
      },
    );
  }
}
