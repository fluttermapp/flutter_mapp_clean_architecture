import '../../../../../core/constants/constants.dart';
import '../../business/entities/avatar_entity.dart';

class AvatarImageModel extends PokemonAvatarEntity {
  const AvatarImageModel({
    required String path,
  }) : super(
          avatarPath: path,
        );

  factory AvatarImageModel.fromJson({required Map<String, dynamic> json}) {
    return AvatarImageModel(
      path: json[kPath],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kPath: avatarPath,
    };
  }
}
