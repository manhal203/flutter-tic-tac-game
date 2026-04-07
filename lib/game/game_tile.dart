import 'package:flutter/material.dart';
import 'package:manhal_project_five/core/colors.dart';
import 'game_controller.dart';

class GameTile extends StatelessWidget {
  final int index;
  final GameController controller;
  final double tileSize;
  const GameTile({
    super.key,
    required this.index,
    required this.controller,
    required this.tileSize,
  });

  @override
  Widget build(BuildContext context) {
    final player = controller.board[index];
    final isWinning = controller.winningIndexes.contains(index);
    final dark = Theme.of(context).brightness == Brightness.dark;

    final fontSize = tileSize * 0.6;
    final borderRadius = tileSize * 0.15;
    final borderWidth = isWinning ? 3.0 : 1.5;

    return GestureDetector(
      onTap: () => controller.playMove(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        decoration: BoxDecoration(
          color:
              dark
                  ? Colors.black.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color:
                isWinning
                    ? AppColors.neonGreen
                    : Colors.white.withValues(alpha: 0.1),
            width: borderWidth,
          ),
        ),
        child: Center(
          child: AnimatedScale(
            scale: player != null ? 1.1 : 1,
            duration: const Duration(milliseconds: 250),
            child: Text(
              player == Player.x
                  ? "X"
                  : player == Player.o
                  ? "O"
                  : "",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color:
                    player == Player.x
                        ? AppColors.neonBlue
                        : AppColors.neonPink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
