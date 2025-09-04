import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:wave_widget/wave_widget.dart';

void main() {
  group('WaveShape Tests', () {
    const testX = 50.0;
    const testWidth = 100.0;
    const testAmplitude = 20.0;
    const testFrequency = 1.0;
    const testPhase = 0.0;
    const testVerticalOffset = 100.0;

    group('SineWave', () {
      test('should compute correct offset', () {
        const sineWave = WaveShape.sine();

        final offset = sineWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);

        // Calculate expected y value: amplitude * sin(pi/width * frequency * x + phase) + verticalOffset
        final expectedY = testAmplitude *
                sin(pi / testWidth * testFrequency * testX + testPhase) +
            testVerticalOffset;
        expect(offset.dy, closeTo(expectedY, 0.001));
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.sine();
        expect(wave, isA<SineShape>());
      });
    });

    group('CosineWave', () {
      test('should compute correct offset', () {
        const cosineWave = WaveShape.cosine();

        final offset = cosineWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);

        // Calculate expected y value: amplitude * cos(pi/width * frequency * x + phase) + verticalOffset
        final expectedY = testAmplitude *
                cos(pi / testWidth * testFrequency * testX + testPhase) +
            testVerticalOffset;
        expect(offset.dy, closeTo(expectedY, 0.001));
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.cosine();
        expect(wave, isA<CosineShape>());
      });
    });

    group('SquareWave', () {
      test('should compute correct offset for positive sine value', () {
        const squareWave = WaveShape.square();

        final offset = squareWave.computeOffset(
          x: 0.0,
          // At x=0, sine should be 0, but we'll test positive case
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: pi / 4,
          // 45 degrees, ensures positive sine
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, 0.0);
        expect(offset.dy,
            testAmplitude + testVerticalOffset); // Should be +amplitude
      });

      test('should compute correct offset for negative sine value', () {
        const squareWave = WaveShape.square();

        final offset = squareWave.computeOffset(
          x: 0.0,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: -pi / 4,
          // Ensures negative sine
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, 0.0);
        expect(offset.dy,
            -testAmplitude + testVerticalOffset); // Should be -amplitude
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.square();
        expect(wave, isA<SquareShape>());
      });
    });

    group('TriangleWave', () {
      test('should compute correct offset', () {
        const triangleWave = WaveShape.triangle();

        final offset = triangleWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
        expect(offset.dy,
            greaterThanOrEqualTo(testVerticalOffset - testAmplitude));
        expect(
            offset.dy, lessThanOrEqualTo(testVerticalOffset + testAmplitude));
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.triangle();
        expect(wave, isA<TriangleShape>());
      });
    });

    group('SawtoothWave', () {
      test('should compute correct offset', () {
        const sawtoothWave = WaveShape.sawtooth();

        final offset = sawtoothWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
        expect(offset.dy,
            greaterThanOrEqualTo(testVerticalOffset - testAmplitude));
        expect(
            offset.dy, lessThanOrEqualTo(testVerticalOffset + testAmplitude));
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.sawtooth();
        expect(wave, isA<SawtoothShape>());
      });
    });

    group('SpiralWave', () {
      test('should create with default spiral factor', () {
        const spiralWave = WaveShape.spiral();
        expect((spiralWave as SpiralShape).spiralFactor, 0.01);
      });

      test('should create with custom spiral factor', () {
        const spiralWave = WaveShape.spiral(spiralFactor: 0.02);
        expect((spiralWave as SpiralShape).spiralFactor, 0.02);
      });

      test('should compute offset with increasing amplitude', () {
        const spiralWave = WaveShape.spiral(spiralFactor: 0.1);

        final offset1 = spiralWave.computeOffset(
          x: 10.0,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        final offset2 = spiralWave.computeOffset(
          x: 50.0,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        // Amplitude should increase with distance due to spiral effect
        final amplitude1 = (offset1.dy - testVerticalOffset).abs();
        final amplitude2 = (offset2.dy - testVerticalOffset).abs();

        expect(amplitude2, greaterThan(amplitude1));
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.spiral(spiralFactor: 0.02);
        expect(wave, isA<SpiralShape>());
        expect((wave as SpiralShape).spiralFactor, 0.02);
      });
    });

    group('HarmonicWave', () {
      test('should create with default harmonics', () {
        const harmonicWave = WaveShape.harmonic();
        expect((harmonicWave as HarmonicShape).harmonics, [1.0, 0.5, 0.25]);
      });

      test('should create with custom harmonics', () {
        const customHarmonics = [1.0, 0.3, 0.1];
        const harmonicWave = WaveShape.harmonic(harmonics: customHarmonics);
        expect((harmonicWave as HarmonicShape).harmonics, customHarmonics);
      });

      test('should compute offset combining multiple harmonics', () {
        const harmonicWave = WaveShape.harmonic(harmonics: [1.0, 0.5]);

        // Use x=25 to avoid sine = 0 case
        final offset = harmonicWave.computeOffset(
          x: 25.0,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, 25.0);
        expect(offset.dy, isA<double>());

        // The result should be different from a simple sine wave
        const sineWave = WaveShape.sine();
        final sineOffset = sineWave.computeOffset(
          x: 25.0,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dy, isNot(closeTo(sineOffset.dy, 0.001)));
      });

      test('should create via factory constructor', () {
        const harmonics = [1.0, 0.3];
        const wave = WaveShape.harmonic(harmonics: harmonics);
        expect(wave, isA<HarmonicShape>());
        expect((wave as HarmonicShape).harmonics, harmonics);
      });
    });

    group('GerstnerWave', () {
      test('should create with default steepness', () {
        const gerstnerWave = WaveShape.gerstner();
        expect((gerstnerWave as GerstnerShape).steepness, 0.5);
      });

      test('should create with custom steepness', () {
        const gerstnerWave = WaveShape.gerstner(steepness: 0.8);
        expect((gerstnerWave as GerstnerShape).steepness, 0.8);
      });

      test('should compute offset with Gerstner wave characteristics', () {
        const gerstnerWave = WaveShape.gerstner();

        final offset = gerstnerWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.gerstner(steepness: 0.8);
        expect(wave, isA<GerstnerShape>());
        expect((wave as GerstnerShape).steepness, 0.8);
      });
    });

    group('MultiDirectionalGerstnerWave', () {
      test('should create with default parameters', () {
        const wave = WaveShape.multiDirectionalGerstner();
        expect(wave, isA<MultiDirectionalGerstnerShape>());
        expect((wave as MultiDirectionalGerstnerShape).steepness, 0.5);
        expect((wave).directions, [0.0, 0.785398, -0.785398]);
        expect((wave).directionWeights, [1.0, 0.6, 0.4]);
      });

      test('should create with custom parameters', () {
        const customDirections = [0.0, 1.5708]; // 0°, 90°
        const customWeights = [0.8, 0.6];
        const wave = WaveShape.multiDirectionalGerstner(
          steepness: 0.7,
          directions: customDirections,
          directionWeights: customWeights,
        );
        expect(wave, isA<MultiDirectionalGerstnerShape>());
        expect((wave as MultiDirectionalGerstnerShape).steepness, 0.7);
        expect((wave).directions, customDirections);
        expect((wave).directionWeights, customWeights);
      });

      test('should compute offset with multi-directional effects', () {
        const wave = WaveShape.multiDirectionalGerstner();

        final offset = wave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
      });
    });

    group('DeepWaterGerstnerWave', () {
      test('should create with default parameters', () {
        const wave = WaveShape.deepWaterGerstner();
        expect(wave, isA<DeepWaterGerstnerShape>());
        expect((wave as DeepWaterGerstnerShape).steepness, 0.4);
        expect((wave).depth, 1.0);
        expect((wave).windSpeed, 10.0);
      });

      test('should create with custom parameters', () {
        const wave = WaveShape.deepWaterGerstner(
          steepness: 0.6,
          depth: 2.0,
          windSpeed: 15.0,
        );
        expect(wave, isA<DeepWaterGerstnerShape>());
        expect((wave as DeepWaterGerstnerShape).steepness, 0.6);
        expect((wave).depth, 2.0);
        expect((wave).windSpeed, 15.0);
      });

      test('should compute offset with deep water effects', () {
        const wave = WaveShape.deepWaterGerstner();

        final offset = wave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
      });

      test('should show wind speed effect on amplitude', () {
        const lowWindWave = WaveShape.deepWaterGerstner(windSpeed: 5.0);
        const highWindWave = WaveShape.deepWaterGerstner(windSpeed: 20.0);

        final lowWindOffset = lowWindWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        final highWindOffset = highWindWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        // High wind should generally produce different wave patterns
        expect(lowWindOffset.dy, isNot(equals(highWindOffset.dy)));
      });
    });

    group('StormGerstnerWave', () {
      test('should create with default parameters', () {
        const wave = WaveShape.stormGerstner();
        expect(wave, isA<StormGerstnerShape>());
        expect((wave as StormGerstnerShape).steepness, 0.8);
        expect((wave).foamFactor, 0.3);
        expect((wave).turbulence, 0.5);
      });

      test('should create with custom parameters', () {
        const wave = WaveShape.stormGerstner(
          steepness: 0.9,
          foamFactor: 0.5,
          turbulence: 0.7,
        );
        expect(wave, isA<StormGerstnerShape>());
        expect((wave as StormGerstnerShape).steepness, 0.9);
        expect((wave).foamFactor, 0.5);
        expect((wave).turbulence, 0.7);
      });

      test('should compute offset with storm effects', () {
        const wave = WaveShape.stormGerstner();

        final offset = wave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
      });

      test('should show turbulence effect', () {
        const calmWave = WaveShape.stormGerstner(turbulence: 0.0);
        const turbulentWave = WaveShape.stormGerstner(turbulence: 1.0);

        final calmOffset = calmWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        final turbulentOffset = turbulentWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        // Turbulent waves should produce different patterns
        expect(calmOffset.dy, isNot(equals(turbulentOffset.dy)));
      });
    });

    group('ShallowGerstnerWave', () {
      test('should create with default parameters', () {
        const wave = WaveShape.shallowGerstner();
        expect(wave, isA<ShallowGerstnerShape>());
        expect((wave as ShallowGerstnerShape).steepness, 0.3);
        expect((wave).shoalingFactor, 1.2);
        expect((wave).bottomFriction, 0.1);
      });

      test('should create with custom parameters', () {
        const wave = WaveShape.shallowGerstner(
          steepness: 0.4,
          shoalingFactor: 1.5,
          bottomFriction: 0.2,
        );
        expect(wave, isA<ShallowGerstnerShape>());
        expect((wave as ShallowGerstnerShape).steepness, 0.4);
        expect((wave).shoalingFactor, 1.5);
        expect((wave).bottomFriction, 0.2);
      });

      test('should compute offset with shallow water effects', () {
        const wave = WaveShape.shallowGerstner();

        final offset = wave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
      });

      test('should show shoaling effect', () {
        const lowShoalingWave = WaveShape.shallowGerstner(shoalingFactor: 1.0);
        const highShoalingWave = WaveShape.shallowGerstner(shoalingFactor: 2.0);

        final lowShoalingOffset = lowShoalingWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        final highShoalingOffset = highShoalingWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        // Higher shoaling should produce different wave heights
        final lowAmplitude = (lowShoalingOffset.dy - testVerticalOffset).abs();
        final highAmplitude =
            (highShoalingOffset.dy - testVerticalOffset).abs();

        expect(highAmplitude, greaterThan(lowAmplitude));
      });

      test('should show bottom friction effect over distance', () {
        const wave = WaveShape.shallowGerstner(bottomFriction: 0.5);

        final nearOffset = wave.computeOffset(
          x: 10.0,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        final farOffset = wave.computeOffset(
          x: 90.0,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        // Bottom friction should reduce amplitude with distance
        final nearAmplitude = (nearOffset.dy - testVerticalOffset).abs();
        final farAmplitude = (farOffset.dy - testVerticalOffset).abs();

        expect(farAmplitude, lessThan(nearAmplitude));
      });
    });

    group('NoiseWave', () {
      test('should create with default parameters', () {
        const noiseWave = WaveShape.noise();
        expect((noiseWave as NoiseShape).noiseFactor, 0.3);
        expect((noiseWave).seed, 42);
      });

      test('should create with custom parameters', () {
        const noiseWave = WaveShape.noise(noiseFactor: 0.5, seed: 123);
        expect((noiseWave as NoiseShape).noiseFactor, 0.5);
        expect((noiseWave).seed, 123);
      });

      test('should compute offset with noise variation', () {
        const noiseWave = WaveShape.noise();

        final offset = noiseWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());

        // Should be different from pure sine wave due to noise
        const sineWave = WaveShape.sine();
        final sineOffset = sineWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dy, isNot(closeTo(sineOffset.dy, 0.001)));
      });

      test('should create via factory constructor', () {
        const wave = WaveShape.noise(noiseFactor: 0.5, seed: 123);
        expect(wave, isA<NoiseShape>());
        expect((wave as NoiseShape).noiseFactor, 0.5);
        expect((wave).seed, 123);
      });
    });

    group('CompositeWave', () {
      test('should create with waves and default weights', () {
        const waves = [WaveShape.sine(), WaveShape.cosine()];
        const compositeWave = WaveShape.composite(waves: waves);

        expect((compositeWave as CompositeShape).waves, waves);
        expect((compositeWave).weights, isNull);
      });

      test('should create with waves and custom weights', () {
        const waves = [WaveShape.sine(), WaveShape.cosine()];
        const weights = [0.7, 0.3];
        const compositeWave =
            WaveShape.composite(waves: waves, weights: weights);

        expect((compositeWave as CompositeShape).waves, waves);
        expect((compositeWave).weights, weights);
      });

      test('should compute offset combining multiple waves', () {
        const waves = [WaveShape.sine(), WaveShape.cosine()];
        const weights = [0.5, 0.5];
        const compositeWave =
            WaveShape.composite(waves: waves, weights: weights);

        final offset = compositeWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());

        // Should be different from individual sine or cosine waves
        const sineWave = WaveShape.sine();
        final sineOffset = sineWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dy, isNot(closeTo(sineOffset.dy, 0.001)));
      });

      test('should handle empty weights by using equal weights', () {
        const waves = [WaveShape.sine(), WaveShape.cosine()];
        const compositeWave = WaveShape.composite(waves: waves);

        final offset = compositeWave.computeOffset(
          x: testX,
          width: testWidth,
          amplitude: testAmplitude,
          frequency: testFrequency,
          phase: testPhase,
          verticalOffset: testVerticalOffset,
        );

        expect(offset.dx, testX);
        expect(offset.dy, isA<double>());
      });
    });
  });
}
