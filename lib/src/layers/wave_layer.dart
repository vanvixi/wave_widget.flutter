import 'package:flutter/rendering.dart';

import '../../waves.dart';

part 'wave_solid_layer.dart';
part 'wave_gradient_layer.dart';

/// Abstract base class for defining wave layer properties and behavior.
///
/// A wave layer represents a single animated wave with customizable visual
/// properties such as duration, height, blur effects, direction, phase offset,
/// and amplitude multiplier. Wave layers can be combined to create complex
/// multi-layered wave animations.
abstract interface class WaveLayer {
  /// Creates a new wave layer with the specified properties.
  ///
  /// [duration] - Animation duration in milliseconds (must be > 0)
  /// [heightFactor] - Vertical position factor (0.0 to 1.0, where 1.0 is full height)
  /// [blur] - Optional blur effect to apply to the wave
  /// [direction] - Wave movement direction (1.0 = forward, -1.0 = backward)
  /// [phaseOffset] - Phase offset in degrees for wave positioning
  /// [amplitudeMultiplier] - Factor to multiply wave amplitude (default: 1.0)
  /// [waveShape] - Shape function for the wave (default: SineWave)
  const WaveLayer({
    required this.duration,
    required this.heightFactor,
    this.blur,
    this.direction = 1.0,
    this.phaseOffset = 0.0,
    this.amplitudeMultiplier = 1.0,
    this.waveShape = const WaveShape.sine(),
  })  : assert(duration > 0.0),
        assert(heightFactor > 0.0 && heightFactor <= 1.0);

  /// Vertical position factor (0.0 to 1.0) determining wave height placement
  final double heightFactor;

  /// Animation duration in milliseconds
  final int duration;

  /// Optional blur effect applied to the wave rendering
  final MaskFilter? blur;

  /// Wave movement direction (1.0 = forward, -1.0 = backward)
  final double direction;

  /// Phase offset in degrees for wave positioning
  final double phaseOffset;

  /// Amplitude multiplier factor for scaling wave height
  final double amplitudeMultiplier;

  /// Shape function defining the wave's mathematical curve
  final WaveShape waveShape;

  /// Creates a solid color wave layer.
  ///
  /// This factory constructor creates a wave layer filled with a single solid color.
  ///
  /// [duration] - Animation duration in milliseconds
  /// [heightFactor] - Vertical position factor (0.0 to 1.0)
  /// [color] - Solid color for the wave
  /// [blur] - Optional blur effect
  /// [direction] - Wave movement direction (default: 1.0)
  /// [phaseOffset] - Phase offset in degrees (default: 0.0)
  /// [amplitudeMultiplier] - Amplitude scaling factor (default: 1.0)
  /// [waveShape] - Wave shape function (default: SineWave)
  const factory WaveLayer.solid({
    required int duration,
    required double heightFactor,
    required Color color,
    MaskFilter? blur,
    double direction,
    double phaseOffset,
    double amplitudeMultiplier,
    WaveShape waveShape,
  }) = WaveSolidLayer;

  /// Creates a gradient-filled wave layer.
  ///
  /// This factory constructor creates a wave layer filled with a gradient.
  ///
  /// [duration] - Animation duration in milliseconds
  /// [heightFactor] - Vertical position factor (0.0 to 1.0)
  /// [gradient] - Gradient for filling the wave
  /// [blur] - Optional blur effect
  /// [direction] - Wave movement direction (default: 1.0)
  /// [phaseOffset] - Phase offset in degrees (default: 0.0)
  /// [amplitudeMultiplier] - Amplitude scaling factor (default: 1.0)
  /// [waveShape] - Wave shape function (default: SineWave)
  const factory WaveLayer.gradient({
    required int duration,
    required double heightFactor,
    required Gradient gradient,
    MaskFilter? blur,
    double direction,
    double phaseOffset,
    double amplitudeMultiplier,
    WaveShape waveShape,
  }) = WaveGradientLayer;

  /// Creates a Paint object for rendering this wave layer.
  ///
  /// [size] - The canvas size for rendering
  /// [verticalOffset] - Vertical offset for wave positioning
  /// [strokeWidth] - Optional stroke width (0.0 for fill, > 0 for stroke)
  ///
  /// Returns a configured Paint object with appropriate styling.
  Paint createPaint({
    required Size size,
    required double verticalOffset,
    double strokeWidth = 0.0,
  });

  @override
  int get hashCode => Object.hash(duration, heightFactor, blur, direction,
      phaseOffset, amplitudeMultiplier);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    final WaveLayer otherLayer = other as WaveLayer;
    return duration == otherLayer.duration &&
        heightFactor == otherLayer.heightFactor &&
        blur == otherLayer.blur &&
        direction == otherLayer.direction &&
        phaseOffset == otherLayer.phaseOffset &&
        amplitudeMultiplier == otherLayer.amplitudeMultiplier;
  }
}
