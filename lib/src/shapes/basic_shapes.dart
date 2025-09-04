part of 'wave_shape.dart';

/// Sine wave implementation.
/// 
/// Creates smooth, natural-looking waves using the mathematical sine function.
/// This is the most common and classic wave pattern.
final class SineShape extends WaveShape {
  /// Creates a sine wave with default parameters.
  const SineShape();

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
    final dy = amplitude * sin(spatialFactor * frequency * x + phase) + verticalOffset;
    return Offset(x, dy);
  }
}

/// Cosine wave implementation.
/// 
/// Similar to sine waves but phase-shifted by 90 degrees, creating waves
/// that start at their peak value rather than zero.
final class CosineShape extends WaveShape {
  /// Creates a cosine wave with default parameters.
  const CosineShape();

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
    final dy = amplitude * cos(spatialFactor * frequency * x + phase) + verticalOffset;
    return Offset(x, dy);
  }
}

/// Square wave implementation.
/// 
/// Creates digital-style waves with sharp transitions between high and low states.
/// Useful for creating geometric or electronic-themed wave effects.
final class SquareShape extends WaveShape {
  /// Creates a square wave with default parameters.
  const SquareShape();

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
    final sinValue = sin(spatialFactor * frequency * x + phase);
    final dy = amplitude * (sinValue >= 0 ? 1 : -1) + verticalOffset;
    return Offset(x, dy);
  }
}

/// Triangle wave implementation.
/// 
/// Creates waves with linear slopes between peaks and troughs, forming
/// triangular shapes. Provides a geometric alternative to smooth curves.
final class TriangleShape extends WaveShape {
  /// Creates a triangle wave with default parameters.
  const TriangleShape();

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
    final normalizedX = (spatialFactor * frequency * x + phase) / (2 * pi);
    final fractionalPart = normalizedX - normalizedX.floor();
    
    double triangleValue;
    if (fractionalPart < 0.25) {
      triangleValue = 4 * fractionalPart;
    } else if (fractionalPart < 0.75) {
      triangleValue = 2 - 4 * fractionalPart;
    } else {
      triangleValue = 4 * fractionalPart - 4;
    }
    
    final dy = amplitude * triangleValue + verticalOffset;
    return Offset(x, dy);
  }
}

/// Sawtooth wave implementation.
/// 
/// Creates waves that rise linearly and then drop sharply, resembling
/// the teeth of a saw. Often used in electronic music and signal processing.
final class SawtoothShape extends WaveShape {
  /// Creates a sawtooth wave with default parameters.
  const SawtoothShape();

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
    final normalizedX = (spatialFactor * frequency * x + phase) / (2 * pi);
    final fractionalPart = normalizedX - normalizedX.floor();
    final dy = amplitude * (2 * fractionalPart - 1) + verticalOffset;
    return Offset(x, dy);
  }
}