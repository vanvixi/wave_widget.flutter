import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import 'consts.dart';
import 'layers/wave_layer.dart';

/// Custom painter responsible for rendering animated wave layers on a canvas.
///
/// The [WavesPainter] takes a list of [WaveLayer]s and renders them as
/// animated wave patterns. It handles the mathematical calculations for
/// wave positions, applies layer-specific properties like direction and
/// phase offset, and manages the overall animation timing.
class WavesPainter extends CustomPainter {
  /// Creates a waves painter with the specified properties.
  ///
  /// [baseDuration] - Base animation duration in milliseconds
  /// [amplitude] - Base amplitude for wave height calculations
  /// [frequency] - Wave frequency affecting density
  /// [layers] - List of wave layers to render
  /// [animation] - Animation object driving the wave movement
  WavesPainter({
    required this.baseDuration,
    required this.amplitude,
    required this.frequency,
    required this.layers,
    required this.animation,
  }) : super(repaint: animation);

  /// Base animation duration in milliseconds used for timing calculations
  final int baseDuration;

  /// Base amplitude controlling overall wave height
  final double amplitude;

  /// Wave frequency affecting the density of wave cycles
  final double frequency;

  /// List of wave layers to render
  final List<WaveLayer> layers;

  /// Animation object providing current animation state
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    for (int layerIndex = 0; layerIndex < layers.length; layerIndex++) {
      final layer = layers[layerIndex];
      if (layer.heightFactor <= 0) continue;
      final verticalOffset = size.height * (1 - layer.heightFactor);
      final layerDuration = layer.duration.toDouble();
      final speedMultiplier = baseDuration / layerDuration;

      final path = Path();

      final animatedPhase =
          (animation.value * 2 * speedMultiplier * layer.direction) +
              (layerIndex * 30) +
              layer.phaseOffset;

      final layerAmplitude = amplitude * layer.amplitudeMultiplier;
      final phaseInRadians = animatedPhase * kDegreesToRadians;

      path.moveTo(
        0.0,
        _computeOffsetForLayer(
          layer: layer,
          x: 0,
          width: size.width,
          amplitude: layerAmplitude,
          phaseInRadians: phaseInRadians,
          verticalOffset: verticalOffset,
        ).dy,
      );

      for (int x = 1; x <= size.width.toInt(); x++) {
        final offset = _computeOffsetForLayer(
          layer: layer,
          x: x.toDouble(),
          width: size.width,
          amplitude: layerAmplitude,
          phaseInRadians: phaseInRadians,
          verticalOffset: verticalOffset,
        );
        path.lineTo(offset.dx, offset.dy);
      }

      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
      path.close();

      final paint =
          layer.createPaint(size: size, verticalOffset: verticalOffset);
      canvas.drawPath(path, paint);
    }
  }

  /// Computes the wave offset for a specific layer at a given x position.
  ///
  /// This method delegates to the layer's wave shape to calculate the
  /// actual wave curve coordinates.
  ///
  /// [layer] - The wave layer to compute offset for
  /// [x] - Horizontal position to calculate
  /// [width] - Total width of the wave canvas
  /// [amplitude] - Amplitude for this calculation
  /// [phaseInRadians] - Current phase in radians
  /// [verticalOffset] - Base vertical offset
  ///
  /// Returns an [Offset] representing the wave position at x.
  Offset _computeOffsetForLayer({
    required WaveLayer layer,
    required double x,
    required double width,
    required double amplitude,
    required double phaseInRadians,
    required double verticalOffset,
  }) {
    return layer.waveShape.computeOffset(
      x: x,
      width: width,
      amplitude: amplitude,
      frequency: frequency,
      phase: phaseInRadians,
      verticalOffset: verticalOffset,
    );
  }

  @override
  bool shouldRepaint(WavesPainter oldDelegate) =>
      oldDelegate.amplitude != amplitude ||
      oldDelegate.frequency != frequency ||
      oldDelegate.layers != layers;
}
