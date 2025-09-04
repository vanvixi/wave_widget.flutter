import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waves/waves.dart';

void main() {
  group('Waves Library Integration Tests', () {
    test('should export all required classes', () {
      // Test that all main classes are accessible
      expect(WaveLayer, isA<Type>());
      expect(WaveShape, isA<Type>());
      expect(WavesWidget, isA<Type>());

      // Test wave layer implementations
      expect(WaveSolidLayer, isA<Type>());
      expect(WaveGradientLayer, isA<Type>());
    });

    test('should create wave layers via factory constructors', () {
      const solidLayer = WaveLayer.solid(
        duration: 2000,
        heightFactor: 0.8,
        color: Color(0xFF0000FF),
      );

      expect(solidLayer, isA<WaveSolidLayer>());
      expect(solidLayer.duration, 2000);
      expect(solidLayer.heightFactor, 0.8);

      const gradientLayer = WaveLayer.gradient(
        duration: 1500,
        heightFactor: 0.6,
        gradient:
            LinearGradient(colors: [Color(0xFF0000FF), Color(0xFF00FF00)]),
      );

      expect(gradientLayer, isA<WaveGradientLayer>());
      expect(gradientLayer.duration, 1500);
      expect(gradientLayer.heightFactor, 0.6);
    });

    test('should create wave shapes via factory constructors', () {
      // Test basic wave shapes
      const sine = WaveShape.sine();
      const cosine = WaveShape.cosine();
      const square = WaveShape.square();
      const triangle = WaveShape.triangle();
      const sawtooth = WaveShape.sawtooth();

      expect(sine, isA<WaveShape>());
      expect(cosine, isA<WaveShape>());
      expect(square, isA<WaveShape>());
      expect(triangle, isA<WaveShape>());
      expect(sawtooth, isA<WaveShape>());

      // Test complex wave shapes
      const spiral = WaveShape.spiral(spiralFactor: 0.02);
      const harmonic = WaveShape.harmonic(harmonics: [1.0, 0.5]);
      const noise = WaveShape.noise(noiseFactor: 0.4, seed: 123);

      expect(spiral, isA<WaveShape>());
      expect(harmonic, isA<WaveShape>());
      expect(noise, isA<WaveShape>());

      // Test all Gerstner wave variants
      const gerstner = WaveShape.gerstner(steepness: 0.8);
      const multiDirectionalGerstner = WaveShape.multiDirectionalGerstner(
        steepness: 0.6,
        directions: [0.0, 1.5708],
        directionWeights: [1.0, 0.7],
      );
      const deepWaterGerstner = WaveShape.deepWaterGerstner(
        steepness: 0.5,
        depth: 2.0,
        windSpeed: 15.0,
      );
      const stormGerstner = WaveShape.stormGerstner(
        steepness: 0.9,
        foamFactor: 0.4,
        turbulence: 0.8,
      );
      const shallowGerstner = WaveShape.shallowGerstner(
        steepness: 0.4,
        shoalingFactor: 1.5,
        bottomFriction: 0.2,
      );

      expect(gerstner, isA<WaveShape>());
      expect(multiDirectionalGerstner, isA<WaveShape>());
      expect(deepWaterGerstner, isA<WaveShape>());
      expect(stormGerstner, isA<WaveShape>());
      expect(shallowGerstner, isA<WaveShape>());
    });

    test('should create complex composite waves', () {
      const compositeWave = WaveShape.composite(
        waves: [WaveShape.sine(), WaveShape.cosine(), WaveShape.square()],
        weights: [0.5, 0.3, 0.2],
      );

      expect(compositeWave, isA<WaveShape>());
    });

    test('should create multi-layer wave configurations', () {
      const layers = [
        WaveLayer.solid(
          duration: 3000,
          heightFactor: 0.9,
          color: Color(0x800000FF),
          direction: 1.0,
          waveShape: WaveShape.sine(),
        ),
        WaveLayer.gradient(
          duration: 2500,
          heightFactor: 0.7,
          gradient:
              LinearGradient(colors: [Color(0x8000FF00), Color(0x80FF0000)]),
          direction: -1.0,
          phaseOffset: 90.0,
          waveShape: WaveShape.cosine(),
        ),
        WaveLayer.solid(
          duration: 2000,
          heightFactor: 0.5,
          color: Color(0x80FFFF00),
          amplitudeMultiplier: 0.7,
          waveShape: WaveShape.harmonic(harmonics: [1.0, 0.5, 0.25]),
        ),
      ];

      expect(layers.length, 3);
      expect(layers[0], isA<WaveSolidLayer>());
      expect(layers[1], isA<WaveGradientLayer>());
      expect(layers[2], isA<WaveSolidLayer>());

      // Verify different configurations
      expect(layers[0].direction, 1.0);
      expect(layers[1].direction, -1.0);
      expect(layers[1].phaseOffset, 90.0);
      expect(layers[2].amplitudeMultiplier, 0.7);
    });

    test('should validate assertions properly', () {
      // Test duration assertion
      expect(
        () => WaveLayer.solid(
          duration: 0,
          heightFactor: 0.5,
          color: const Color(0xFF0000FF),
        ),
        throwsAssertionError,
      );

      // Test heightFactor assertions
      expect(
        () => WaveLayer.solid(
          duration: 2000,
          heightFactor: 0.0,
          color: const Color(0xFF0000FF),
        ),
        throwsAssertionError,
      );

      expect(
        () => WaveLayer.solid(
          duration: 2000,
          heightFactor: 1.5,
          color: const Color(0xFF0000FF),
        ),
        throwsAssertionError,
      );
    });
  });
}
