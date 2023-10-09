class NoParams {}

class TemplateParams {}

class PokemonParams {
  final String id;
  const PokemonParams({
    required this.id,
  });
}

class PokemonAvatarParams {
  final String name;
  final String imageUrl;

  const PokemonAvatarParams({
    required this.name,
    required this.imageUrl
  });
}
