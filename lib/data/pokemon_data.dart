import '../models/pokemon.dart';

class PokemonData {
  static List<Pokemon> get allPokemon => _allPokemonData;

  static final List<Pokemon> _allPokemonData = [
    Pokemon(name: 'Pikachu', imageUrl: '../assets/pokemons/pikachu.png', id: 1),
    Pokemon(
      name: 'Bulbasaur',
      imageUrl: '../assets/pokemons/bulbasaur.png',
      id: 2,
    ),
    Pokemon(
      name: 'Charmander',
      imageUrl: '../assets/pokemons/charmander.png',
      id: 3,
    ),
    Pokemon(
      name: 'Squirtle',
      imageUrl: '../assets/pokemons/squirtle.png',
      id: 4,
    ),
    Pokemon(name: 'Eevee', imageUrl: '../assets/pokemons/eevee.png', id: 5),
    Pokemon(
      name: 'Jigglypuff',
      imageUrl: '../assets/pokemons/jigglypuff.png',
      id: 6,
    ),
    // Add many more Pokémon here with unique IDs
    Pokemon(name: 'Snorlax', imageUrl: '../assets/pokemons/snorlax.png', id: 7),
    Pokemon(name: 'Mewtwo', imageUrl: '../assets/pokemons/mewtwo.png', id: 8),
    Pokemon(name: 'Gengar', imageUrl: '../assets/pokemons/gengar.png', id: 9),
    Pokemon(name: 'Vulpix', imageUrl: '../assets/pokemons/vulpix.png', id: 10),
    Pokemon(
      name: 'Psyduck',
      imageUrl: '../assets/pokemons/psyduck.png',
      id: 11,
    ),
    Pokemon(name: 'Togepi', imageUrl: '../assets/pokemons/togepi.png', id: 12),
  ];
}
