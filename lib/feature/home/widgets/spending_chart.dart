import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class SpendingChart extends StatelessWidget {
  const SpendingChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Spending Trends",
            style: TextStyle(
              color: ColorsManager.textGrey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                "\$1,850.00",
                style: TextStyle(
                  color: ColorsManager.textDark,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Higher than last month",
                style: TextStyle(
                  color: ColorsManager.expenseRed.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1.7,
            child: CustomPaint(
              painter: _ChartPainter(),
              child: Stack(
                children: const [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Text("WEEK 1",
                          style: TextStyle(
                              fontSize: 10, color: ColorsManager.textGrey))),
                  Positioned(
                      bottom: 0,
                      left: 100,
                      child: Text("WEEK 2",
                          style: TextStyle(
                              fontSize: 10, color: ColorsManager.textGrey))),
                  Positioned(
                      bottom: 0,
                      right: 100,
                      child: Text("WEEK 3",
                          style: TextStyle(
                              fontSize: 10, color: ColorsManager.textGrey))),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text("WEEK 4",
                          style: TextStyle(
                              fontSize: 10, color: ColorsManager.textGrey))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorsManager.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    // Simulate data points based on visual
    // Start low, go up, dip slightly, go high, dip

    final h = size.height;
    final w = size.width;

    path.moveTo(0, h * 0.8);
    path.cubicTo(
        w * 0.2, h * 0.4, w * 0.3, h * 0.6, w * 0.5, h * 0.2); // First hump
    path.cubicTo(
        w * 0.7, -h * 0.2, w * 0.8, h * 0.9, w, h * 0.4); // Second hump dip

    canvas.drawPath(path, paint);

    // Add gradient fill
    final fillPath = Path.from(path);
    fillPath.lineTo(w, h);
    fillPath.lineTo(0, h);
    fillPath.close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        ColorsManager.primaryBlue.withValues(alpha: 0.2),
        ColorsManager.primaryBlue.withValues(alpha: 0.0),
      ],
    );

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(fillPath, fillPaint);

    // Draw dots
    final dotPaint = Paint()..color = ColorsManager.primaryBlue;
    canvas.drawCircle(Offset(w * 0.5, h * 0.2), 4, dotPaint);
    canvas.drawCircle(Offset(w * 0.25, h * 0.56), 4, dotPaint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.65), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
