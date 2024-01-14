import '../../../../../core/constants/constants.dart';
import '../../business/entities/pokemon_image_entity.dart';

class PokemonImageModel extends PokemonImageEntity {
  const PokemonImageModel({
    required String path,
  }) : super(
          path: path,
        );

  factory PokemonImageModel.fromJson({required Map<String, dynamic> json}) {
    return PokemonImageModel(
      path: json[kPath],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kPath: path,
    };
  }
}
