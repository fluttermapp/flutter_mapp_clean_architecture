import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../../../params/params.dart';
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
