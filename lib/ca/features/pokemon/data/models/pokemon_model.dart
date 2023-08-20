import 'sub_models.dart';
import '../../../../../core/constants/constants.dart';
import '../../business/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required String name,
    required int id,
    required SpritesModel sprites,
    required List<TypesModel> types,
  }) : super(
          name: name,
          id: id,
          sprites: sprites,
          types: types,
        );

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json[kName],
      id: json[kId],
      sprites: SpritesModel.fromJson(json[kSprites]),
      types: TypesModel.fromJson(json[kTypes]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kName: name,
      kId: id,
      kSprites: sprites,
      kTypes: types,
    };
  }
}
