import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wave_widget/wave_widget.dart';

void main() {
  group('WavesPainter Tests', () {
    const testSize = Size(400, 200);

    const testLayers = [
      WaveLayer.solid(
        duration: 2000,
        heightFactor: 0.8,
        color: Colors.blue,
      ),
      WaveLayer.solid(
        duration: 1500,
        heightFactor: 0.6,
        color: Colors.green,
      ),
    ];

    group('shouldRepaint', () {
      testWidgets('should be accessible and functional',
          (WidgetTester tester) async {
        // Test that WavesPainter can be used in a CustomPaint widget
        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: testLayers,
        );

        await tester.pumpWidget(wavesWidget);

        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
        expect(find.byType(WavesWidget), findsOneWidget);
      });

      testWidgets('should handle empty layers list',
          (WidgetTester tester) async {
        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: [], // Empty layers
        );

        await tester.pumpWidget(wavesWidget);

        final dynamic exception = tester.takeException();
        expect(exception, isA<ArgumentError>());
        expect(exception.toString(), contains('waveLayers must not be empty'));
      });

      testWidgets('should handle different wave shapes',
          (WidgetTester tester) async {
        const layers = [
          WaveLayer.solid(
            duration: 2000,
            heightFactor: 0.8,
            color: Colors.blue,
            waveShape: SineShape(),
          ),
          WaveLayer.solid(
            duration: 1500,
            heightFactor: 0.6,
            color: Colors.green,
            waveShape: CosineShape(),
          ),
          WaveLayer.solid(
            duration: 1000,
            heightFactor: 0.4,
            color: Colors.red,
            waveShape: SquareShape(),
          ),
        ];

        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: layers,
        );

        await tester.pumpWidget(wavesWidget);

        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle gradient layers', (WidgetTester tester) async {
        const layers = [
          WaveLayer.gradient(
            duration: 2000,
            heightFactor: 0.8,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan],
            ),
          ),
          WaveLayer.gradient(
            duration: 1500,
            heightFactor: 0.6,
            gradient: RadialGradient(
              colors: [Colors.green, Colors.lightGreen],
            ),
          ),
        ];

        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: layers,
        );

        await tester.pumpWidget(wavesWidget);

        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle layers with different directions',
          (WidgetTester tester) async {
        const layers = [
          WaveLayer.solid(
            duration: 2000,
            heightFactor: 0.8,
            color: Colors.blue,
            direction: 1.0, // Forward
          ),
          WaveLayer.solid(
            duration: 1500,
            heightFactor: 0.6,
            color: Colors.green,
            direction: -1.0, // Backward
          ),
        ];

        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: layers,
        );

        await tester.pumpWidget(wavesWidget);

        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle layers with phase offsets',
          (WidgetTester tester) async {
        const layers = [
          WaveLayer.solid(
            duration: 2000,
            heightFactor: 0.8,
            color: Colors.blue,
            phaseOffset: 0.0,
          ),
          WaveLayer.solid(
            duration: 1500,
            heightFactor: 0.6,
            color: Colors.green,
            phaseOffset: 90.0, // 90 degrees offset
          ),
        ];

        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: layers,
        );

        await tester.pumpWidget(wavesWidget);

        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle layers with amplitude multipliers',
          (WidgetTester tester) async {
        const layers = [
          WaveLayer.solid(
            duration: 2000,
            heightFactor: 0.8,
            color: Colors.blue,
            amplitudeMultiplier: 1.0,
          ),
          WaveLayer.solid(
            duration: 1500,
            heightFactor: 0.6,
            color: Colors.green,
            amplitudeMultiplier: 0.5, // Half amplitude
          ),
        ];

        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: layers,
        );

        await tester.pumpWidget(wavesWidget);

        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
      });

      testWidgets('should animate waves', (WidgetTester tester) async {
        const wavesWidget = WavesWidget(
          size: testSize,
          waveLayers: testLayers,
        );

        await tester.pumpWidget(wavesWidget);

        // Initial frame
        await tester.pump();

        // Advance animation
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
      });
    });
  });
}
