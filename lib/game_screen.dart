import 'package:flutter/material.dart';
import 'package:manhal_project_five/game/game_board.dart';
import 'package:manhal_project_five/game/game_controller.dart';
import 'package:manhal_project_five/game/score_board.dart';
import 'package:manhal_project_five/game/win_overlay.dart';
import 'package:manhal_project_five/core/colors.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class GameScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const GameScreen({
    super.key,
    required this.isDark,
    required this.toggleTheme,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameController controller;
  String? message;
  bool isWinAnimation = false;

  @override
  void initState() {
    super.initState();
    controller = GameController(
      onUpdate: () {
        setState(() {
          if (controller.winner != null) {
            message =
                "${controller.winner == Player.x ? 'Player X' : 'Player O'} Wins!";
            isWinAnimation = true;
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                message = null;
                isWinAnimation = false;
              });
            });
          } else if (!controller.board.contains(null) &&
              controller.winner == null) {
            message = "Draw!";
            isWinAnimation = false;
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                message = null;
              });
            });
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = widget.isDark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: dark ? AppColors.darkGradient : AppColors.lightGradient,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double boardSize =
                  constraints.maxWidth < constraints.maxHeight
                      ? constraints.maxWidth * 0.9
                      : constraints.maxHeight * 0.6;

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tic Tac Toe",
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  _headerIcon(
                                    Icons.refresh,
                                    32,
                                    () => setState(() => controller.resetAll()),
                                  ),
                                  const SizedBox(width: 8),
                                  _headerIcon(
                                    FontAwesomeIcons.eraser,
                                    32,
                                    () => setState(() => controller.undoMove()),
                                  ),
                                  const SizedBox(width: 8),
                                  _headerIcon(
                                    Icons.translate_outlined,
                                    32,
                                    () {},
                                  ),
                                  const SizedBox(width: 8),
                                  _headerIcon(
                                    dark
                                        ? Icons.dark_mode_outlined
                                        : Icons.light_mode_outlined,
                                    35,
                                    widget.toggleTheme,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          ScoreBoard(controller: controller),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: boardSize,
                            height: boardSize,
                            child: GameBoard(controller: controller),
                          ),
                          const SizedBox(height: 70),
                        ],
                      ),
                    ),
                  ),
                  if (message != null)
                    WinOverlay(message: message!, isWin: isWinAnimation),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _headerIcon(IconData icon, double size, VoidCallback onTap) {
    final dark = widget.isDark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color:
              dark
                  ? Colors.black.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Icon(icon, size: size * 0.5, color: Colors.white),
      ),
    );
  }
}
