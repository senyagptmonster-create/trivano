import 'package:flutter/material.dart';
import '../theme/trivano_theme.dart';

class BackpackWeightPainter extends CustomPainter {
  final double shelterKg;
  final double sleepKg;
  final double cookKg;
  final double clothesKg;

  BackpackWeightPainter({
    required this.shelterKg,
    required this.sleepKg,
    required this.cookKg,
    required this.clothesKg,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final totalBaseKg = shelterKg + sleepKg + cookKg + clothesKg;

    // Backpack silhouette contour
    final packPath = Path()
      ..moveTo(w * 0.28, h * 0.18)
      ..quadraticBezierTo(w * 0.5, h * 0.12, w * 0.72, h * 0.18)
      ..lineTo(w * 0.76, h * 0.82)
      ..quadraticBezierTo(w * 0.5, h * 0.88, w * 0.24, h * 0.82)
      ..close();

    final bgPaint = Paint()
      ..color = TrivanoTheme.edge.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;
    canvas.drawPath(packPath, bgPaint);

    final borderPaint = Paint()
      ..color = TrivanoTheme.edge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(packPath, borderPaint);

    // Top brain pocket
    final brainPath = Path()
      ..moveTo(w * 0.32, h * 0.24)
      ..lineTo(w * 0.68, h * 0.24);
    canvas.drawPath(brainPath, borderPaint);

    // Fill tiers representing categories
    if (totalBaseKg > 0) {
      final fillBottom = h * 0.80;
      final fillTop = h * 0.26;
      final fillH = fillBottom - fillTop;

      final shelterRatio = shelterKg / totalBaseKg;
      final sleepRatio = sleepKg / totalBaseKg;
      final cookRatio = cookKg / totalBaseKg;
      final clothesRatio = clothesKg / totalBaseKg;

      double currentY = fillBottom;

      // 1. Shelter tier (bottom)
      final sH = fillH * shelterRatio;
      _drawTier(canvas, w, currentY - sH, currentY, TrivanoTheme.accent);
      currentY -= sH;

      // 2. Sleep system tier
      final slH = fillH * sleepRatio;
      _drawTier(canvas, w, currentY - slH, currentY, TrivanoTheme.accentLight);
      currentY -= slH;

      // 3. Cookware tier
      final ctkH = fillH * cookRatio;
      _drawTier(canvas, w, currentY - ctkH, currentY, const Color(0xFFF59E0B));
      currentY -= ctkH;

      // 4. Clothing tier
      final clH = fillH * clothesRatio;
      _drawTier(canvas, w, currentY - clH, currentY, const Color(0xFF38BDF8));
    }
  }

  void _drawTier(Canvas canvas, double w, double top, double bottom, Color color) {
    if (top >= bottom) return;
    final r = Rect.fromLTRB(w * 0.32, top, w * 0.68, bottom);
    final paint = Paint()
      ..color = color.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)), paint);
  }

  @override
  bool shouldRepaint(covariant BackpackWeightPainter oldDelegate) {
    return oldDelegate.shelterKg != shelterKg ||
        oldDelegate.sleepKg != sleepKg ||
        oldDelegate.cookKg != cookKg ||
        oldDelegate.clothesKg != clothesKg;
  }
}
