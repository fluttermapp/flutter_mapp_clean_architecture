import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/template_entity.dart';

abstract class TemplateRepository {
  Future<({Failure? failure, TemplateEntity? template})> getTemplate({
    required TemplateParams templateParams,
  });
}
