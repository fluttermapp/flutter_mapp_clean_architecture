class NoParams {}

class PokemonParams {
  final String id;
  const PokemonParams({
    required this.id,
  });
}

class PokemonImageParams {
  final String name;
  final String imagePath;
  const PokemonImageParams({
    required this.name,
    required this.imagePath,
  });
}
