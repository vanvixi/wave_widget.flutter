part of 'wave_shape.dart';

/// Gerstner wave implementation.
///
/// A more realistic water wave simulation that creates sharper crests
/// and rounder troughs, mimicking the behavior of real ocean waves.
final class GerstnerShape extends WaveShape {
  /// Creates a Gerstner wave.
  ///
  /// [steepness] - Controls the sharpness of wave crests (default: 0.5)
  const GerstnerShape({this.steepness = 0.5});

  /// Factor controlling wave steepness and crest sharpness
  final double steepness;

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
    final k = spatialFactor * frequency;
    final theta = k * x + phase;

    final horizontalDisp = steepness * amplitude * cos(theta);
    final baseVerticalDisp = amplitude * sin(theta);

    final gerstnerVertical = baseVerticalDisp + (horizontalDisp * 0.3);

    final dy = gerstnerVertical + verticalOffset;
    return Offset(x, dy);
  }
}

/// Multi-directional Gerstner wave implementation.
/// 
/// Simulates realistic ocean waves by combining wave trains from multiple directions,
/// creating complex interference patterns similar to real ocean conditions.
final class MultiDirectionalGerstnerShape extends WaveShape {
  /// Creates a multi-directional Gerstner wave.
  /// 
  /// [steepness] - Controls the sharpness of wave crests (default: 0.5)
  /// [directions] - Wave direction angles in radians (default: [0, π/4, -π/4])
  /// [directionWeights] - Amplitude weights for each direction (default: [1.0, 0.6, 0.4])
  const MultiDirectionalGerstnerShape({
    this.steepness = 0.5,
    this.directions = const [0.0, 0.785398, -0.785398], // 0°, 45°, -45°
    this.directionWeights = const [1.0, 0.6, 0.4],
  });

  /// Factor controlling wave steepness and crest sharpness
  final double steepness;
  
  /// List of wave direction angles in radians
  final List<double> directions;
  
  /// Amplitude weights for each wave direction
  final List<double> directionWeights;

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
    double totalVertical = 0.0;

    for (int i = 0; i < directions.length; i++) {
      final weight = i < directionWeights.length ? directionWeights[i] : 1.0;
      final direction = directions[i];
      
      final k = spatialFactor * frequency;
      final directionFactor = cos(direction);
      
      final theta = k * (x * directionFactor) + phase + (i * pi / 3);
      
      final horizontalDisp = steepness * amplitude * weight * cos(theta);
      final baseVerticalDisp = amplitude * weight * sin(theta);
      
      totalVertical += baseVerticalDisp + (horizontalDisp * 0.2);
    }

    final dy = totalVertical + verticalOffset;
    return Offset(x, dy);
  }
}

/// Deep water Gerstner wave implementation.
/// 
/// Implements realistic deep water wave physics with proper dispersion relation,
/// where wave speed depends on wavelength, creating natural wave behavior.
final class DeepWaterGerstnerShape extends WaveShape {
  /// Creates a deep water Gerstner wave.
  /// 
  /// [steepness] - Controls the sharpness of wave crests (default: 0.4)
  /// [depth] - Water depth factor affecting wave behavior (default: 1.0)
  /// [windSpeed] - Wind speed factor for wave generation (default: 10.0)
  const DeepWaterGerstnerShape({
    this.steepness = 0.4,
    this.depth = 1.0,
    this.windSpeed = 10.0,
  });

  /// Factor controlling wave steepness and crest sharpness
  final double steepness;
  
  /// Water depth factor affecting wave dispersion
  final double depth;
  
  /// Wind speed factor influencing wave characteristics
  final double windSpeed;

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
    final k = spatialFactor * frequency;
    
    // Deep water dispersion relation: ω² = gk (where g ≈ 9.8)
    const gravity = 9.8;
    final omega = sqrt(gravity * k * depth);
    
    // Wind-wave interaction
    final windEffect = windSpeed / 10.0;
    final enhancedAmplitude = amplitude * (1 + windEffect * 0.1);
    
    final theta = k * x - omega * phase * 0.01 + phase;
    
    final horizontalDisp = steepness * enhancedAmplitude * cos(theta);
    final baseVerticalDisp = enhancedAmplitude * sin(theta);
    
    // Add dispersion effects
    final dispersionFactor = 1 + (k * depth * 0.1);
    final gerstnerVertical = baseVerticalDisp * dispersionFactor + (horizontalDisp * 0.25);

    final dy = gerstnerVertical + verticalOffset;
    return Offset(x, dy);
  }
}

/// Storm Gerstner wave implementation.
/// 
/// Creates dramatic storm waves with foam crests, turbulence, and chaotic behavior
/// typical of severe weather conditions at sea.
final class StormGerstnerShape extends WaveShape {
  /// Creates a storm Gerstner wave.
  /// 
  /// [steepness] - Controls the sharpness of wave crests (default: 0.8)
  /// [foamFactor] - Controls foam generation on wave crests (default: 0.3)
  /// [turbulence] - Controls wave turbulence and irregularity (default: 0.5)
  const StormGerstnerShape({
    this.steepness = 0.8,
    this.foamFactor = 0.3,
    this.turbulence = 0.5,
  });

  /// Factor controlling wave steepness and crest sharpness
  final double steepness;
  
  /// Factor controlling foam generation on wave crests
  final double foamFactor;
  
  /// Factor controlling wave turbulence and irregularity
  final double turbulence;

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
    final k = spatialFactor * frequency;
    final theta = k * x + phase;
    
    // Base Gerstner wave with high steepness
    final horizontalDisp = steepness * amplitude * cos(theta);
    final baseVerticalDisp = amplitude * sin(theta);
    
    // Add turbulence using multiple frequency components
    final turbulence1 = turbulence * amplitude * 0.3 * sin(k * x * 2.1 + phase * 1.3);
    final turbulence2 = turbulence * amplitude * 0.2 * sin(k * x * 3.7 + phase * 0.7);
    final turbulence3 = turbulence * amplitude * 0.15 * cos(k * x * 1.9 + phase * 2.1);
    
    // Foam effect on wave crests (higher amplitude near peaks)
    final foamHeight = foamFactor * amplitude * max(0, sin(theta).clamp(0.7, 1.0) - 0.7) * 3.33;
    
    // Combine all effects
    final totalTurbulence = turbulence1 + turbulence2 + turbulence3;
    final stormVertical = baseVerticalDisp + (horizontalDisp * 0.4) + totalTurbulence + foamHeight;

    final dy = stormVertical + verticalOffset;
    return Offset(x, dy);
  }
}

/// Shallow water Gerstner wave implementation.
/// 
/// Simulates waves in shallow water where the depth affects wave behavior,
/// including shoaling effects and bottom friction that alter wave characteristics.
final class ShallowGerstnerShape extends WaveShape {
  /// Creates a shallow water Gerstner wave.
  /// 
  /// [steepness] - Controls the sharpness of wave crests (default: 0.3)
  /// [shoalingFactor] - Controls shallow water shoaling effects (default: 1.2)
  /// [bottomFriction] - Controls bottom friction effects (default: 0.1)
  const ShallowGerstnerShape({
    this.steepness = 0.3,
    this.shoalingFactor = 1.2,
    this.bottomFriction = 0.1,
  });

  /// Factor controlling wave steepness and crest sharpness
  final double steepness;
  
  /// Factor controlling shallow water shoaling effects
  final double shoalingFactor;
  
  /// Factor controlling bottom friction effects
  final double bottomFriction;

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
    final k = spatialFactor * frequency;
    final theta = k * x + phase;
    
    // Shoaling amplification (waves get steeper in shallow water)
    final shoaledAmplitude = amplitude * shoalingFactor;
    
    // Bottom friction causes energy dissipation
    final frictionDamping = exp(-bottomFriction * x * 0.001);
    final dampedAmplitude = shoaledAmplitude * frictionDamping;
    
    // Shallow water modifies the wave shape (more peaked crests, flatter troughs)
    final horizontalDisp = steepness * dampedAmplitude * cos(theta);
    final baseVerticalDisp = dampedAmplitude * sin(theta);
    
    // Nonlinear shallow water effects (asymmetric wave profile)
    final nonlinearFactor = 1 + (steepness * 0.5 * cos(2 * theta));
    final shallowVertical = baseVerticalDisp * nonlinearFactor + (horizontalDisp * 0.2);

    final dy = shallowVertical + verticalOffset;
    return Offset(x, dy);
  }
}