import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/game_view_model.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GameViewModel>(context);
    final numberOfCards = viewModel.pokemonCards.length;
    int crossAxisCount = 2; // Minimum columns

    if (numberOfCards == 6) {
      crossAxisCount = 2;
    } else if (numberOfCards == 8) {
      crossAxisCount = 4;
    } else if (numberOfCards == 10) {
      crossAxisCount = 5;
    } else if (numberOfCards == 12) {
      crossAxisCount = 4; // Or 3, depending on preference
    } else if (numberOfCards == 14) {
      crossAxisCount = 4;
    } else if (numberOfCards == 16) {
      crossAxisCount = 4;
    } else if (numberOfCards == 18) {
      crossAxisCount = 4;
    } else if (numberOfCards == 20) {
      crossAxisCount = 5;
    } else if (numberOfCards > 20) {
      crossAxisCount = 6; // Or a number that fits reasonably across the screen
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Pokémon Match!')),
        leading:
            Navigator.canPop(context)
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
                : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Level: ${viewModel.currentLevel}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Matches: ${viewModel.currentLevelScore}/${GameViewModel.levelPairs[viewModel.currentLevel] ?? 3}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: numberOfCards,
              itemBuilder: (context, index) {
                final pokemon = viewModel.pokemonCards[index];
                final isRevealed = viewModel.isRevealed[index];

                return GestureDetector(
                  onTap: () {
                    viewModel.cardTapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Center(
                      child:
                          isRevealed
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(pokemon.imageUrl),
                              )
                              : const Text(
                                '?',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.resetGame();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
