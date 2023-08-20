import 'package:dartz/dartz.dart';
import '../../../errors/failure.dart';
import '../../../usecases/usecase.dart';
import '../../data/models/template_model.dart';

abstract class TemplateRepository {
  Future<Either<Failure, TemplateModel>> getTemplate({
    required NoParams params,
  });
}
