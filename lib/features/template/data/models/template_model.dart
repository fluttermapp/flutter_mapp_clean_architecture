import '../../../../../core/constants/constants.dart';
import '../../business/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  const TemplateModel({
    required super.template,
  });

  factory TemplateModel.fromJson({required Map<String, dynamic> json}) {
    return TemplateModel(
      template: json[kTemplate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTemplate: template,
    };
  }
}
