import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../core/extension/media_query_extension.dart';

class DonutChartData {
  final double value;
  final Color color;

  DonutChartData(this.value, this.color);
}

class DonutChart extends StatelessWidget {
  final List<DonutChartData> data;
  final String totalAmount;

  const DonutChart({super.key, required this.data, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.h(0.2),
      width: context.w(0.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(context.w(0.5), context.h(0.2)),
            painter: _DonutChartPainter(data),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "TOTAL SPENT",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: ColorsManager.textGrey,
                ),
              ),
              SizedBox(height: context.h(0.01)),
              Text(
                totalAmount,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final List<DonutChartData> data;

  _DonutChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 25.0;
    final rect = Rect.fromCircle(
      center: center,
      radius: radius - strokeWidth / 2,
    );

    final total = data.fold(0.0, (sum, item) => sum + item.value);

    double startAngle = -pi / 2; // Start from top

    for (var item in data) {
      final sweepAngle = (item.value / total) * 2 * pi;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = item.color
        ..strokeCap = StrokeCap.butt; // Clean edges for segments

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
