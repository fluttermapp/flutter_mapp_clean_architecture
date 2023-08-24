import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/template_entity.dart';
import '../repositories/template_repository.dart';

class GetTemplate {
  final TemplateRepository repository;

  GetTemplate(this.repository);

  Future<Either<Failure, TemplateEntity>> call({
    required NoParams params,
  }) async {
    return await repository.getTemplate(params: params);
  }
}
