import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final double percentage; // 0 to 100

  const GradientProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final double clampedPercent = percentage.clamp(0, 100);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double trackWidth = constraints.maxWidth;
        final double thumbPosition = trackWidth * (clampedPercent / 100);

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Gradient track
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
              ),
            ),
            // Thumb
            Positioned(
              left: thumbPosition - 6, // center the thumb
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.purple.shade800, width: 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
