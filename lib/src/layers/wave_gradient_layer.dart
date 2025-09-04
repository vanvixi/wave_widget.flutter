part of 'wave_layer.dart';

/// A wave layer implementation that renders with a gradient fill.
///
/// This class extends [WaveLayer] to provide gradient rendering capabilities.
/// The wave is filled with a [Gradient] and can optionally be rendered
/// as a stroke instead of a fill by specifying a stroke width.
final class WaveGradientLayer extends WaveLayer {
  /// Creates a gradient-filled wave layer.
  ///
  /// [duration] - Animation duration in milliseconds
  /// [heightFactor] - Vertical position factor (0.0 to 1.0)
  /// [gradient] - Gradient for filling the wave
  /// [blur] - Optional blur effect
  /// [direction] - Wave movement direction (default: 1.0)
  /// [phaseOffset] - Phase offset in degrees (default: 0.0)
  /// [amplitudeMultiplier] - Amplitude scaling factor (default: 1.0)
  /// [waveShape] - Wave shape function (default: SineWave)
  const WaveGradientLayer({
    required super.duration,
    required super.heightFactor,
    required this.gradient,
    super.blur,
    super.direction = 1.0,
    super.phaseOffset = 0.0,
    super.amplitudeMultiplier = 1.0,
    super.waveShape = const WaveShape.sine(),
  });

  /// The gradient used to fill the wave
  final Gradient gradient;

  @override
  Paint createPaint({
    required Size size,
    required double verticalOffset,
    double strokeWidth = 0.0,
  }) {
    final paint = Paint();

    if (strokeWidth > 0 && strokeWidth.isFinite) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
    } else {
      paint.style = PaintingStyle.fill;
      final rect = Rect.fromLTWH(
          0, verticalOffset, size.width, size.height - verticalOffset);
      paint.shader = gradient.createShader(rect);
    }

    if (blur != null) {
      paint.maskFilter = blur;
    }

    return paint;
  }

  @override
  int get hashCode => Object.hash(duration, heightFactor, blur, gradient,
      direction, phaseOffset, amplitudeMultiplier);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    final WaveGradientLayer otherLayer = other as WaveGradientLayer;
    return duration == otherLayer.duration &&
        heightFactor == otherLayer.heightFactor &&
        blur == otherLayer.blur &&
        gradient == otherLayer.gradient &&
        direction == otherLayer.direction &&
        phaseOffset == otherLayer.phaseOffset &&
        amplitudeMultiplier == otherLayer.amplitudeMultiplier;
  }
}
