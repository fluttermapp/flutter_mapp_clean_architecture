import 'package:dartz/dartz.dart';
import 'package:flutter_mapp_clean_architecture/core/template/business/entities/template_entity.dart';
import '../../../errors/failure.dart';
import '../../../params/params.dart';

abstract class TemplateRepository {
  Future<Either<Failure, TemplateEntity>> getTemplate({
    required NoParams params,
  });
}
