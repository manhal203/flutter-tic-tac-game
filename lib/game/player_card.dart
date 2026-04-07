import 'package:flutter/material.dart';
import 'package:manhal_project_five/core/colors.dart';
import 'game_controller.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final GameController controller;

  const PlayerCard({super.key, required this.player, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final isActive = controller.currentPlayer == player;
    final isWinner =
        controller.winningIndexes.isNotEmpty &&
        controller.board[controller.winningIndexes.first] == player;
    final color = player == Player.x ? AppColors.neonBlue : AppColors.neonPink;

    final width = MediaQuery.of(context).size.width;
    final padding = width * 0.04;
    final fontSize = width * 0.1;
    final borderRadius = width * 0.05;
    final spacing = width * 0.02;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.glass(dark),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color:
              isWinner
                  ? AppColors.neonGreen
                  : isActive
                  ? color
                  : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            player == Player.x ? "X" : "O",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spacing),
          Text(
            player == Player.x ? "Player X" : "Player O",
            style: TextStyle(fontSize: fontSize * 0.5),
          ),
        ],
      ),
    );
  }
}
