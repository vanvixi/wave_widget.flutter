part of 'wave_layer.dart';

/// A wave layer implementation that renders with a solid color fill.
///
/// This class extends [WaveLayer] to provide solid color rendering capabilities.
/// The wave is filled with a single [Color] and can optionally be rendered
/// as a stroke instead of a fill by specifying a stroke width.
final class WaveSolidLayer extends WaveLayer {
  /// Creates a solid color wave layer.
  ///
  /// [duration] - Animation duration in milliseconds
  /// [heightFactor] - Vertical position factor (0.0 to 1.0)
  /// [color] - Solid color for the wave
  /// [blur] - Optional blur effect
  /// [direction] - Wave movement direction (default: 1.0)
  /// [phaseOffset] - Phase offset in degrees (default: 0.0)
  /// [amplitudeMultiplier] - Amplitude scaling factor (default: 1.0)
  /// [waveShape] - Wave shape function (default: SineWave)
  const WaveSolidLayer({
    required super.duration,
    required super.heightFactor,
    required this.color,
    super.blur,
    super.direction = 1.0,
    super.phaseOffset = 0.0,
    super.amplitudeMultiplier = 1.0,
    super.waveShape = const WaveShape.sine(),
  });

  /// The solid color used to fill or stroke the wave
  final Color color;

  @override
  Paint createPaint({
    required Size size,
    required double verticalOffset,
    double strokeWidth = 0.0,
  }) {
    final Paint paint = Paint()..color = color;
    if (strokeWidth > 0 && strokeWidth.isFinite) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
    } else {
      paint.style = PaintingStyle.fill;
    }

    if (blur != null) {
      paint.maskFilter = blur;
    }

    return paint;
  }

  @override
  int get hashCode => Object.hash(duration, heightFactor, blur, color,
      direction, phaseOffset, amplitudeMultiplier);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    final WaveSolidLayer otherLayer = other as WaveSolidLayer;
    return duration == otherLayer.duration &&
        heightFactor == otherLayer.heightFactor &&
        blur == otherLayer.blur &&
        color == otherLayer.color &&
        direction == otherLayer.direction &&
        phaseOffset == otherLayer.phaseOffset &&
        amplitudeMultiplier == otherLayer.amplitudeMultiplier;
  }
}
