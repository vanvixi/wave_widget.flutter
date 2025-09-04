part of 'wave_shape.dart';

/// Spiral wave implementation.
///
/// Creates waves where the amplitude increases progressively with distance,
/// forming a spiral pattern that grows outward from the starting point.
final class SpiralShape extends WaveShape {
  /// Creates a spiral wave.
  ///
  /// [spiralFactor] - Controls how quickly the amplitude increases with distance (default: 0.01)
  const SpiralShape({this.spiralFactor = 0.01});

  /// Factor controlling the spiral growth rate
  final double spiralFactor;

  @override
  Offset computeOffset({
    required double x,
    required double width,
    required double amplitude,
    required double frequency,
    required double phase,
    required double verticalOffset,
  }) {
    final spatialFactor = pi / width;
    final spiralAmplitude = amplitude * (1 + spiralFactor * x);
    final dy = spiralAmplitude * sin(spatialFactor * frequency * x + phase) +
        verticalOffset;
    return Offset(x, dy);
  }
}

/// Harmonic wave implementation.
///
/// Combines multiple sine waves at different frequencies to create
/// complex harmonic patterns, similar to how musical instruments work.
final class HarmonicShape extends WaveShape {
  /// Creates a harmonic wave.
  ///
  /// [harmonics] - List of amplitude multipliers for each harmonic (default: [1.0, 0.5, 0.25])
  const HarmonicShape({this.harmonics = const [1.0, 0.5, 0.25]});

  /// List of amplitude multipliers for each harmonic frequency
  final List<double> harmonics;

  @override
  Offset computeOffset({
    required double x,
    required double width,
    required double amplitude,
    required double frequency,
    required double phase,
    required double verticalOffset,
  }) {
    final spatialFactor = pi / width;
    double totalValue = 0.0;

    for (int i = 0; i < harmonics.length; i++) {
      final harmonicFreq = frequency * (i + 1);
      totalValue +=
          harmonics[i] * sin(spatialFactor * harmonicFreq * x + phase);
    }

    final dy = amplitude * totalValue + verticalOffset;
    return Offset(x, dy);
  }
}

/// Noise wave implementation.
///
/// Adds random variations to a base sine wave, creating a more
/// natural, turbulent wave pattern.
final class NoiseShape extends WaveShape {
  /// Creates a noise wave.
  ///
  /// [noiseFactor] - Controls the intensity of random noise (default: 0.3)
  /// [seed] - Random seed for reproducible noise patterns (default: 42)
  const NoiseShape({this.noiseFactor = 0.3, this.seed = 42});

  /// Factor controlling the intensity of random noise
  final double noiseFactor;

  /// Random seed for reproducible noise patterns
  final int seed;

  @override
  Offset computeOffset({
    required double x,
    required double width,
    required double amplitude,
    required double frequency,
    required double phase,
    required double verticalOffset,
  }) {
    final spatialFactor = pi / width;
    final baseWave = amplitude * sin(spatialFactor * frequency * x + phase);

    final random = Random(seed + x.toInt());
    final noise = (random.nextDouble() - 0.5) * 2 * amplitude * noiseFactor;

    final dy = baseWave + noise + verticalOffset;
    return Offset(x, dy);
  }
}

/// Composite wave implementation.
///
/// Combines multiple wave shapes together with optional weighting,
/// allowing for complex wave patterns by layering different wave types.
final class CompositeShape extends WaveShape {
  /// Creates a composite wave from multiple wave shapes.
  ///
  /// [waves] - List of wave shapes to combine
  /// [weights] - Optional weights for each wave (default: equal weight for all)
  const CompositeShape({required this.waves, this.weights});

  /// List of wave shapes to combine
  final List<WaveShape> waves;

  /// Optional weights for combining waves
  final List<double>? weights;

  @override
  Offset computeOffset({
    required double x,
    required double width,
    required double amplitude,
    required double frequency,
    required double phase,
    required double verticalOffset,
  }) {
    if (waves.isEmpty) {
      return Offset(x, verticalOffset);
    }

    double totalY = 0.0;
    double totalWeight = 0.0;

    for (int i = 0; i < waves.length; i++) {
      final weight =
          (weights != null && i < weights!.length) ? weights![i] : 1.0;
      final waveOffset = waves[i].computeOffset(
        x: x,
        width: width,
        amplitude: amplitude,
        frequency: frequency,
        phase: phase,
        verticalOffset: 0, // Don't apply vertical offset to individual waves
      );

      totalY += waveOffset.dy * weight;
      totalWeight += weight;
    }

    final averageY = totalWeight > 0 ? totalY / totalWeight : 0.0;
    return Offset(x, averageY + verticalOffset);
  }
}
