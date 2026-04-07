import 'package:flutter/material.dart';
import 'package:manhal_project_five/core/colors.dart';
import 'package:lottie/lottie.dart';

class WinOverlay extends StatelessWidget {
  final String message;
  final bool isWin;

  const WinOverlay({super.key, required this.message, required this.isWin});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    final paddingH = width * 0.08;
    final paddingV = width * 0.05;
    final borderRadius = width * 0.05;
    final fontSize = width * 0.065;

    return Positioned.fill(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: paddingH,
              vertical: paddingV,
            ),
            decoration: BoxDecoration(
              color:
                  dark
                      ? Colors.black.withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: AppColors.neonGreen, width: 2),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.neonGreen,
              ),
            ),
          ),
          if (isWin)
            Positioned.fill(
              child: IgnorePointer(
                child: Lottie.asset(
                  'assets/animations/Confetti.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
