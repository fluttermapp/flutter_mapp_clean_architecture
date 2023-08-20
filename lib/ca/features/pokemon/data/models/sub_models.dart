import '../../../../../core/constants/constants.dart';
import '../../business/entities/sub_entites.dart';

//! Sprites
class SpritesModel extends SpritesEntity {
  const SpritesModel({
    required OtherModel other,
  }) : super(other: other);

  static SpritesModel fromJson(Map<String, dynamic> json) {
    return SpritesModel(
      other: OtherModel.fromJson(json[kOther]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kOther: other,
    };
  }
}

class OtherModel extends OtherEntity {
  const OtherModel({
    required OfficialArtworkModel officialArtwork,
  }) : super(officialArtwork: officialArtwork);

  static OtherModel fromJson(Map<String, dynamic> json) {
    return OtherModel(
      officialArtwork: OfficialArtworkModel.fromJson(json[kOfficialArtwork]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kOfficialArtwork: officialArtwork,
    };
  }
}

class OfficialArtworkModel extends OfficialArtworkEntity {
  const OfficialArtworkModel({
    required String frontDefault,
    required String frontShiny,
  }) : super(
          frontDefault: frontDefault,
          frontShiny: frontShiny,
        );

  static OfficialArtworkModel fromJson(Map<String, dynamic> json) {
    return OfficialArtworkModel(
      frontDefault: json[kFrontDefault],
      frontShiny: json[kFrontShiny],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kFrontDefault: frontDefault,
      kFrontShiny: frontShiny,
    };
  }
}

//! Types
class TypesModel extends TypesEntity {
  const TypesModel({
    required TypeModel type,
  }) : super(type: type);

  static List<TypesModel> fromJson(List<dynamic> jsonList) {
    List<TypesModel> returnedList = [];
    for (Map<String, dynamic> json in jsonList) {
      returnedList.add(
        TypesModel(
          type: TypeModel.fromJson(json[kType]),
        ),
      );
    }
    return returnedList;
  }

  Map<String, dynamic> toJson() {
    return {
      kType: type,
    };
  }
}

class TypeModel extends TypeEntity {
  const TypeModel({
    required String name,
  }) : super(name: name);

  static TypeModel fromJson(Map<String, dynamic> json) {
    return TypeModel(
      name: json[kName],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kName: name,
    };
  }
}

