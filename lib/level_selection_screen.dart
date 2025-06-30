import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/game_view_model.dart';
import 'game_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final availableLevels = GameViewModel.levelPairs.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Select Level'))),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust the number of columns as needed
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.5,
        ),
        itemCount: availableLevels.length,
        itemBuilder: (context, index) {
          final level = availableLevels[index];
          return InkWell(
            onTap: () {
              // Navigate to GameScreen and start at the selected level
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const GameScreen()),
              );
              // Inform the GameViewModel to initialize with the selected level
              Provider.of<GameViewModel>(
                context,
                listen: false,
              ).startLevel(level);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  'Level $level',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
