import 'dart:convert';

import 'package:flutter_mapp_clean_architecture/features/pokemon_avatar/data/models/avatar_image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';

abstract class AvatarImageLocalDataSource {
  Future<void> cacheAvatarImage({required AvatarImageModel? avatarImageToCache});
  Future<AvatarImageModel> getLastAvatarImage();
}

const cachedAvatarImage = 'CACHED_AVATAR_IMAGE';

class AvatarImageLocalDataSourceImpl implements AvatarImageLocalDataSource {
  final SharedPreferences sharedPreferences;

  AvatarImageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AvatarImageModel> getLastAvatarImage() {
    final jsonString = sharedPreferences.getString(cachedAvatarImage);

    if (jsonString != null) {
      return Future.value(AvatarImageModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAvatarImage({required AvatarImageModel? avatarImageToCache}) async {
    if (avatarImageToCache != null) {
      sharedPreferences.setString(
        cachedAvatarImage,
        json.encode(
          avatarImageToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
