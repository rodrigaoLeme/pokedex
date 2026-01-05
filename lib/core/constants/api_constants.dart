import 'dart:core';

/// Constantes da API
/// Centraliza URLs e configurações da PokéAPI.

class ApiConstants {
  // Base URL
  static const String baseUrl = "https://pokeapi.co/api/v2";

  // Endpoints
  static const String pokemonEndpoint = '/pokemon';
  static const String pokemonSpeciesEndpoint = '/pokemon-species';
  static const String typeEndpoint = '/type';
  static const String abilityEndpoint = '/ability';

  // Paginação
  static const int defaultLimit = 20;
  static const int defaultOffset = 0;

  // Timouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // URLs completas (helpers)
  static String getPokemonListUrl(
      {int limit = defaultLimit, int offset = defaultOffset}) {
    return '$baseUrl$pokemonEndpoint?limit=$limit&offset=$offset';
  }

  static String getPokemonDetailUrl(int id) {
    return '$baseUrl$pokemonEndpoint/$id';
  }

  static String getPokemonDetailByNameUrl(String name) {
    return '$baseUrl$pokemonEndpoint/$name';
  }

  static String getPokemonSpeciesUrl(int id) {
    return '$baseUrl$pokemonSpeciesEndpoint/$id';
  }

  static String getTypeUrl(int id) {
    return '$baseUrl$typeEndpoint/$id';
  }

  // Imagens
  static String getPokemonImageUrl(int id) {
    // Artwork oficial de alta qualidade
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  static String getPomemonSpriteUrl(int id) {
    // Sprite alternativo (menor)
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  ApiConstants._(); // Construtor privado
}
