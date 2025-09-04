import 'dart:math';
import 'dart:ui';

part 'basic_shapes.dart';
part 'complex_shapes.dart';
part 'gerstner_shapes.dart';

/// Abstract base class for defining wave shape mathematical functions.
/// 
/// A [WaveShape] defines how a wave curve is calculated at any given point.
/// Different wave shapes produce different visual patterns, from simple
/// sine waves to complex composite waves with harmonics and noise.
/// 
/// Implementations must provide the [computeOffset] method that calculates
/// the wave's y-coordinate for a given x-coordinate and wave parameters.
abstract class WaveShape {
  const WaveShape();

  /// Computes the wave offset at a specific horizontal position.
  ///
  /// This method calculates the wave's y-coordinate based on the
  /// mathematical function defined by the specific wave shape.
  ///
  /// [x] - Horizontal position along the wave
  /// [width] - Total width of the wave canvas
  /// [amplitude] - Maximum displacement from the center line
  /// [frequency] - Number of wave cycles across the width
  /// [phase] - Phase offset in radians for wave positioning
  /// [verticalOffset] - Base vertical offset from the top
  /// 
  /// Returns an [Offset] with the calculated wave position.
  Offset computeOffset({
    required double x,
    required double width,
    required double amplitude,
    required double frequency,
    required double phase,
    required double verticalOffset,
  });

  // Basic wave shapes
  /// Creates a standard sine wave shape
  const factory WaveShape.sine() = SineShape;

  /// Creates a cosine wave shape (sine wave shifted by π/2)
  const factory WaveShape.cosine() = CosineShape;

  /// Creates a square wave shape with sharp transitions
  const factory WaveShape.square() = SquareShape;

  /// Creates a triangular wave shape with linear segments
  const factory WaveShape.triangle() = TriangleShape;

  /// Creates a sawtooth wave shape with sharp drops
  const factory WaveShape.sawtooth() = SawtoothShape;

  // Complex wave shapes
  /// Creates a spiral wave with increasing amplitude over distance
  /// [spiralFactor] - Controls how quickly the amplitude increases (default: 0.01)
  const factory WaveShape.spiral({double spiralFactor}) = SpiralShape;

  /// Creates a harmonic wave combining multiple sine waves
  /// [harmonics] - List of amplitude multipliers for each harmonic
  const factory WaveShape.harmonic({List<double> harmonics}) = HarmonicShape;

  /// Creates a noisy wave by adding random variations to a sine wave
  /// [noiseFactor] - Controls noise intensity (default: 0.3)
  /// [seed] - Random seed for reproducible noise (default: 42)
  const factory WaveShape.noise({double noiseFactor, int seed}) = NoiseShape;

  /// Creates a composite wave from multiple wave shapes
  /// [waves] - List of wave shapes to combine
  /// [weights] - Optional weights for each wave (default: equal weight for all)
  const factory WaveShape.composite({
    required List<WaveShape> waves,
    List<double>? weights,
  }) = CompositeShape;

  // Gerstner wave family
  /// Creates a Gerstner wave with more realistic water-like motion
  /// [steepness] - Controls the sharpness of wave crests (default: 0.5)
  const factory WaveShape.gerstner({double steepness}) = GerstnerShape;

  /// Creates a multi-directional Gerstner wave with wave trains from different angles
  /// [steepness] - Controls the sharpness of wave crests (default: 0.5)
  /// [directions] - List of wave direction angles in radians (default: [0, π/4, -π/4])
  /// [directionWeights] - Amplitude weights for each direction (default: [1.0, 0.6, 0.4])
  const factory WaveShape.multiDirectionalGerstner({
    double steepness,
    List<double> directions,
    List<double> directionWeights,
  }) = MultiDirectionalGerstnerShape;

  /// Creates a deep water Gerstner wave with realistic dispersion relation
  /// [steepness] - Controls the sharpness of wave crests (default: 0.4)
  /// [depth] - Water depth factor affecting wave behavior (default: 1.0)
  /// [windSpeed] - Wind speed factor for wave generation (default: 10.0)
  const factory WaveShape.deepWaterGerstner({
    double steepness,
    double depth,
    double windSpeed,
  }) = DeepWaterGerstnerShape;

  /// Creates a storm wave using enhanced Gerstner wave with foam and turbulence
  /// [steepness] - Controls the sharpness of wave crests (default: 0.8)
  /// [foamFactor] - Controls foam generation on wave crests (default: 0.3)
  /// [turbulence] - Controls wave turbulence and irregularity (default: 0.5)
  const factory WaveShape.stormGerstner({
    double steepness,
    double foamFactor,
    double turbulence,
  }) = StormGerstnerShape;

  /// Creates a shallow water Gerstner wave with nonlinear effects
  /// [steepness] - Controls the sharpness of wave crests (default: 0.3)
  /// [shoalingFactor] - Controls shallow water shoaling effects (default: 1.2)
  /// [bottomFriction] - Controls bottom friction effects (default: 0.1)
  const factory WaveShape.shallowGerstner({
    double steepness,
    double shoalingFactor,
    double bottomFriction,
  }) = ShallowGerstnerShape;
}