import 'dart:ui';
import 'package:flutter/material.dart';
import 'game_controller.dart';
import 'game_tile.dart';

class GameBoard extends StatelessWidget {
  final GameController controller;
  const GameBoard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        double boardSize =
            (constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth
                : constraints.maxHeight) *
            1;

        final spacing = boardSize * 0.03;
        final aspectRatio = 1.0;

        return Center(
          child: SizedBox(
            width: boardSize,
            height: boardSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(boardSize * 0.08),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: EdgeInsets.all(boardSize * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(boardSize * 0.08),
                    color:
                        dark
                            ? Colors.black.withValues(alpha: 0.1)
                            : Colors.white.withValues(alpha: 0.3),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 2,
                    ),
                  ),
                  child: GridView.builder(
                    itemCount: 9,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: aspectRatio,
                    ),
                    itemBuilder:
                        (context, index) => GameTile(
                          index: index,
                          controller: controller,
                          tileSize: boardSize / 3,
                        ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
