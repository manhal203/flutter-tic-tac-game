import 'package:flutter/material.dart';
import 'package:manhal_project_five/core/colors.dart';
import 'player_card.dart';
import 'game_controller.dart';

class ScoreBoard extends StatelessWidget {
  final GameController controller;

  const ScoreBoard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    final containerPadding = width * 0.03;
    final borderRadius = width * 0.04;
    final spacing = width * 0.04;
    final scoreFontSize = width * 0.05;
    final labelFontSize = width * 0.025;
    final playerSpacing = width * 0.03;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: containerPadding),
          decoration: BoxDecoration(
            color: dark
                ? Colors.black.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: dark
                  ? Colors.black.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _scoreItem("Player X", controller.xScore, AppColors.neonBlue, scoreFontSize, labelFontSize),
              _scoreItem("Draws", controller.draws, Colors.white, scoreFontSize, labelFontSize),
              _scoreItem("Player O", controller.oScore, AppColors.neonPink, scoreFontSize, labelFontSize),
            ],
          ),
        ),
        SizedBox(height: spacing),
        Row(
          children: [
            Expanded(
              child: PlayerCard(player: Player.x, controller: controller),
            ),
            SizedBox(width: playerSpacing),
            Expanded(
              child: PlayerCard(player: Player.o, controller: controller),
            ),
          ],
        ),
      ],
    );
  }

  Widget _scoreItem(String label, int score, Color color, double scoreFontSize, double labelFontSize) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            "$score",
            key: ValueKey(score),
            style: TextStyle(
              fontSize: scoreFontSize,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
        SizedBox(height: labelFontSize * 0.25),
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}