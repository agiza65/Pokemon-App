import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../data/pokemon_data.dart';

class GameViewModel extends ChangeNotifier {
  int _currentLevel = 1;
  int _currentLevelScore = 0;
  List<Pokemon> _pokemonCards = [];
  List<bool> _isRevealed = [];
  List<int?> _flippedIndices = [];
  int _totalScore = 0;

  GameViewModel() {
    // Removed the initial call to _initializeGame
  }

  int get currentLevel => _currentLevel;
  int get currentLevelScore => _currentLevelScore;
  List<Pokemon> get pokemonCards => _pokemonCards;
  List<bool> get isRevealed => _isRevealed;
  int get totalScore => _totalScore;

  static const Map<int, int> levelPairs = {
    1: 3,
    2: 4,
    3: 5,
    4: 6,
    5: 7,
    6: 8,
    7: 9,
    8: 10,
    9: 11,
    10: 12,
  };

  void startLevel(int level) {
    _currentLevel = level;
    _initializeGame(level);
  }

  void _initializeGame(int level) {
    final numberOfPairs = levelPairs[level] ?? 3;
    final allPokemon = PokemonData.allPokemon;

    if (allPokemon.length < numberOfPairs) {
      print('Error: Not enough Pokémon data for level $level');
      _pokemonCards = [];
      _isRevealed = [];
      _flippedIndices = [];
      _currentLevelScore = 0;
      notifyListeners();
      return;
    }

    allPokemon.shuffle();
    final selectedPokemon = allPokemon.take(numberOfPairs).toList();

    _pokemonCards =
        selectedPokemon
            .expand(
              (pokemon) => [
                Pokemon(
                  name: pokemon.name,
                  imageUrl: pokemon.imageUrl,
                  id: pokemon.id,
                ),
                Pokemon(
                  name: pokemon.name,
                  imageUrl: pokemon.imageUrl,
                  id: pokemon.id,
                ),
              ],
            )
            .toList();
    _pokemonCards.shuffle();

    _isRevealed = List.generate(_pokemonCards.length, (index) => false);
    _flippedIndices = [];
    _currentLevelScore = 0;
    notifyListeners();
  }

  void cardTapped(int index) {
    if (_flippedIndices.length < 2 &&
        !_isRevealed[index] &&
        !_flippedIndices.contains(index)) {
      _isRevealed[index] = true;
      _flippedIndices.add(index);
      notifyListeners();

      if (_flippedIndices.length == 2) {
        Future.delayed(const Duration(milliseconds: 500), _checkForMatch);
      }
    }
  }

  void _checkForMatch() {
    if (_flippedIndices.length == 2) {
      int firstIndex = _flippedIndices[0]!;
      int secondIndex = _flippedIndices[1]!;

      if (_pokemonCards[firstIndex].id == _pokemonCards[secondIndex].id) {
        _currentLevelScore++;
        _flippedIndices.clear();
        notifyListeners();
        _checkIfLevelComplete();
      } else {
        Future.delayed(const Duration(milliseconds: 800), () {
          _isRevealed[firstIndex] = false;
          _isRevealed[secondIndex] = false;
          _flippedIndices.clear();
          notifyListeners();
        });
      }
    }
  }

  void _checkIfLevelComplete() {
    if (_currentLevelScore == levelPairs[_currentLevel]) {
      _totalScore += _currentLevelScore;
      _currentLevel++;
      if (levelPairs.containsKey(_currentLevel)) {
        _initializeGame(_currentLevel);
      } else {
        print('Game Over! All levels completed. Total score: $_totalScore');
        // Navigate to game over screen later
      }
    }
  }

  void resetGame() {
    startLevel(1); // Reset to level 1
    _totalScore = 0;
  }
}
