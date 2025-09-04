import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_waves/flutter_waves.dart';

void main() {
  group('WaveLayer Tests', () {
    group('WaveSolidLayer', () {
      test('should create with required parameters', () {
        const layer = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        expect(layer.duration, 2000);
        expect(layer.heightFactor, 0.5);
        expect(layer.color, Colors.blue);
        expect(layer.direction, 1.0);
        expect(layer.phaseOffset, 0.0);
        expect(layer.amplitudeMultiplier, 1.0);
        expect(layer.waveShape, isA<SineShape>());
      });

      test('should create with all parameters', () {
        const blur = MaskFilter.blur(BlurStyle.normal, 2.0);
        const waveShape = CosineShape();

        const layer = WaveSolidLayer(
          duration: 1500,
          heightFactor: 0.8,
          color: Colors.red,
          blur: blur,
          direction: -1.0,
          phaseOffset: 45.0,
          amplitudeMultiplier: 1.5,
          waveShape: waveShape,
        );

        expect(layer.duration, 1500);
        expect(layer.heightFactor, 0.8);
        expect(layer.color, Colors.red);
        expect(layer.blur, blur);
        expect(layer.direction, -1.0);
        expect(layer.phaseOffset, 45.0);
        expect(layer.amplitudeMultiplier, 1.5);
        expect(layer.waveShape, waveShape);
      });

      test('should create paint with fill style by default', () {
        const layer = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        final paint = layer.createPaint(
          size: const Size(100, 100),
          verticalOffset: 50,
        );

        expect(paint.color.value, Colors.blue.value);
        expect(paint.style, PaintingStyle.fill);
        expect(paint.strokeWidth, 0.0);
      });

      test('should create paint with stroke style when strokeWidth is provided',
          () {
        const layer = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        final paint = layer.createPaint(
          size: const Size(100, 100),
          verticalOffset: 50,
          strokeWidth: 2.0,
        );

        expect(paint.color.value, Colors.blue.value);
        expect(paint.style, PaintingStyle.stroke);
        expect(paint.strokeWidth, 2.0);
      });

      test('should apply blur when provided', () {
        const blur = MaskFilter.blur(BlurStyle.normal, 2.0);
        const layer = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
          blur: blur,
        );

        final paint = layer.createPaint(
          size: const Size(100, 100),
          verticalOffset: 50,
        );

        expect(paint.maskFilter, blur);
      });

      test('should implement equality correctly', () {
        const layer1 = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        const layer2 = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        const layer3 = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.red,
        );

        expect(layer1, equals(layer2));
        expect(layer1, isNot(equals(layer3)));
      });

      test('should implement hashCode correctly', () {
        const layer1 = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        const layer2 = WaveSolidLayer(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        expect(layer1.hashCode, equals(layer2.hashCode));
      });

      test('should enforce duration assertion', () {
        expect(
          () => WaveSolidLayer(
            duration: 0,
            heightFactor: 0.5,
            color: Colors.blue,
          ),
          throwsAssertionError,
        );
      });

      test('should enforce heightFactor assertions', () {
        expect(
          () => WaveSolidLayer(
            duration: 2000,
            heightFactor: 0.0,
            color: Colors.blue,
          ),
          throwsAssertionError,
        );

        expect(
          () => WaveSolidLayer(
            duration: 2000,
            heightFactor: 1.5,
            color: Colors.blue,
          ),
          throwsAssertionError,
        );
      });
    });

    group('WaveGradientLayer', () {
      test('should create with required parameters', () {
        const gradient = LinearGradient(
          colors: [Colors.blue, Colors.green],
        );

        const layer = WaveGradientLayer(
          duration: 2000,
          heightFactor: 0.5,
          gradient: gradient,
        );

        expect(layer.duration, 2000);
        expect(layer.heightFactor, 0.5);
        expect(layer.gradient, gradient);
        expect(layer.direction, 1.0);
        expect(layer.phaseOffset, 0.0);
        expect(layer.amplitudeMultiplier, 1.0);
      });

      test('should create paint with gradient shader for fill', () {
        const gradient = LinearGradient(
          colors: [Colors.blue, Colors.green],
        );

        const layer = WaveGradientLayer(
          duration: 2000,
          heightFactor: 0.5,
          gradient: gradient,
        );

        final paint = layer.createPaint(
          size: const Size(100, 100),
          verticalOffset: 50,
        );

        expect(paint.style, PaintingStyle.fill);
        expect(paint.shader, isNotNull);
      });

      test('should create paint with stroke style when strokeWidth is provided',
          () {
        const gradient = LinearGradient(
          colors: [Colors.blue, Colors.green],
        );

        const layer = WaveGradientLayer(
          duration: 2000,
          heightFactor: 0.5,
          gradient: gradient,
        );

        final paint = layer.createPaint(
          size: const Size(100, 100),
          verticalOffset: 50,
          strokeWidth: 2.0,
        );

        expect(paint.style, PaintingStyle.stroke);
        expect(paint.strokeWidth, 2.0);
      });

      test('should implement equality correctly', () {
        const gradient1 = LinearGradient(colors: [Colors.blue, Colors.green]);
        const gradient2 = LinearGradient(colors: [Colors.blue, Colors.green]);
        const gradient3 = LinearGradient(colors: [Colors.red, Colors.yellow]);

        const layer1 = WaveGradientLayer(
          duration: 2000,
          heightFactor: 0.5,
          gradient: gradient1,
        );

        const layer2 = WaveGradientLayer(
          duration: 2000,
          heightFactor: 0.5,
          gradient: gradient2,
        );

        const layer3 = WaveGradientLayer(
          duration: 2000,
          heightFactor: 0.5,
          gradient: gradient3,
        );

        expect(layer1, equals(layer2));
        expect(layer1, isNot(equals(layer3)));
      });
    });

    group('WaveLayer Factory Constructors', () {
      test('should create solid layer via factory', () {
        const layer = WaveLayer.solid(
          duration: 2000,
          heightFactor: 0.5,
          color: Colors.blue,
        );

        expect(layer, isA<WaveSolidLayer>());
        expect(layer.duration, 2000);
        expect((layer as WaveSolidLayer).color, Colors.blue);
      });

      test('should create gradient layer via factory', () {
        const gradient = LinearGradient(colors: [Colors.blue, Colors.green]);

        const layer = WaveLayer.gradient(
          duration: 2000,
          heightFactor: 0.5,
          gradient: gradient,
        );

        expect(layer, isA<WaveGradientLayer>());
        expect(layer.duration, 2000);
        expect((layer as WaveGradientLayer).gradient, gradient);
      });
    });
  });
}
