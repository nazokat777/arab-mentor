import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GeometricPatternBackground extends StatelessWidget {
  final Widget child;
  final double opacity;
  final Color? color;

  const GeometricPatternBackground({
    super.key,
    required this.child,
    this.opacity = 0.06,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _IslamicStarPainter(
                color: (color ?? AppColors.emerald).withOpacity(opacity),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _IslamicStarPainter extends CustomPainter {
  final Color color;
  _IslamicStarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const tileSize = 80.0;
    for (double y = -tileSize; y < size.height + tileSize; y += tileSize) {
      for (double x = -tileSize; x < size.width + tileSize; x += tileSize) {
        _drawEightPointStar(
          canvas,
          Offset(x + tileSize / 2, y + tileSize / 2),
          tileSize / 2.6,
          paint,
        );
      }
    }
  }

  void _drawEightPointStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    const points = 8;
    final inner = radius * 0.5;
    for (int i = 0; i < points * 2; i++) {
      final r = i.isEven ? radius : inner;
      final angle = (i * pi / points) - pi / 2;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OrnamentDivider extends StatelessWidget {
  final Color? color;
  const OrnamentDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.gold;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container(height: 1, color: c.withOpacity(0.4))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.diamond_outlined, color: c, size: 18),
          ),
          Expanded(child: Container(height: 1, color: c.withOpacity(0.4))),
        ],
      ),
    );
  }
}

class GoldFrame extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const GoldFrame({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.gold.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
