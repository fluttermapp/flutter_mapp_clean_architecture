class NoParams {}

class TemplateParams {}

class PokemonParams {
  final String id;
  const PokemonParams({
    required this.id,
  });
}

class PokemonImageParams {
  final String url;
  final String name;
  const PokemonImageParams({
    required this.url,
    required this.name,
  });
}