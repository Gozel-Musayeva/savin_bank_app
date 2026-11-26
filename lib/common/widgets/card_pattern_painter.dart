import 'package:flutter/widgets.dart';

/// Tiles the Figma card pattern: a 10×10 grid of squares (1 = filled),
/// repeated across and down the card.
class CardPatternPainter extends CustomPainter {
  const CardPatternPainter({
    required this.color,
    required this.cell,
    required this.offsetX,
  });

  final Color color;
  final double cell;
  final double offsetX;

  static const _tile = [
    '0000100010',
    '0001001010',
    '0010000010',
    '0100010000',
    '1000010100',
    '0000010001',
    '0011110010',
    '1000000100',
    '0001001000',
    '1100010011',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final n = _tile.length;
    final cols = ((size.width - offsetX) / cell).ceil() + 1;
    final rows = (size.height / cell).ceil();
    for (var r = 0; r < rows; r++) {
      final line = _tile[r % n];
      for (var c = -1; c < cols; c++) {
        if (line[c % n] != '1') continue;
        canvas.drawRect(
          Rect.fromLTWH(offsetX + c * cell, r * cell, cell, cell),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CardPatternPainter old) =>
      old.color != color || old.cell != cell || old.offsetX != offsetX;
}
