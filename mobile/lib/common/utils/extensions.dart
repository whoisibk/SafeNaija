import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Replaces deprecated [withOpacity] with [withValues]
  Color withOp(double opacity) => withValues(alpha: opacity);
}
