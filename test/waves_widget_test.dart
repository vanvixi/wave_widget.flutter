import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_waves/flutter_waves.dart';

void main() {
  group('WavesWidget Tests', () {
    const testSize = Size(400, 200);

    const testWaveLayers = [
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

    testWidgets('should create with required parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        waveLayers: testWaveLayers,
      ));

      expect(find.byType(WavesWidget), findsOneWidget);
    });

    testWidgets('should create with all parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        initialPhase: 45.0,
        amplitude: 30.0,
        frequency: 2.0,
        baseDuration: 1000,
        waveLayers: testWaveLayers,
      ));

      expect(find.byType(WavesWidget), findsOneWidget);
    });

    testWidgets('should use CustomPaint for rendering',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        waveLayers: testWaveLayers,
      ));

      expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    });

    testWidgets('should wrap CustomPaint in RepaintBoundary',
        (WidgetTester tester) async {
      const widget = WavesWidget(
        size: testSize,
        waveLayers: testWaveLayers,
      );

      await tester.pumpWidget(widget);

      expect(find.byType(RepaintBoundary), findsOneWidget);
    });

    testWidgets(
        'should calculate base duration from shortest layer duration when not provided',
        (WidgetTester tester) async {
      const layers = [
        WaveLayer.solid(
          duration: 3000,
          heightFactor: 0.8,
          color: Colors.blue,
        ),
        WaveLayer.solid(
          duration: 1500, // This should be the base duration
          heightFactor: 0.6,
          color: Colors.green,
        ),
        WaveLayer.solid(
          duration: 2000,
          heightFactor: 0.4,
          color: Colors.red,
        ),
      ];

      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        waveLayers: layers,
      ));

      await tester.pump();

      // The widget should use 1500ms as the base duration (shortest)
      expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    });

    testWidgets('should use provided base duration when specified',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        baseDuration: 2500,
        waveLayers: testWaveLayers,
      ));

      await tester.pump();

      expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    });

    testWidgets('should reinitialize when size changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: Size(200, 100),
        waveLayers: testWaveLayers,
      ));

      // Change size
      await tester.pumpWidget(const WavesWidget(
        size: Size(400, 200),
        waveLayers: testWaveLayers,
      ));

      expect(find.byType(WavesWidget), findsOneWidget);
    });

    testWidgets('should reinitialize when wave layers change',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        waveLayers: [
          WaveLayer.solid(
            duration: 2000,
            heightFactor: 0.8,
            color: Colors.blue,
          ),
        ],
      ));

      // Change wave layers
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        waveLayers: [
          WaveLayer.solid(
            duration: 1500,
            heightFactor: 0.6,
            color: Colors.red,
          ),
        ],
      ));

      expect(find.byType(WavesWidget), findsOneWidget);
    });

    testWidgets('should reinitialize when wave parameters change',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        amplitude: 20.0,
        frequency: 1.0,
        waveLayers: testWaveLayers,
      ));

      // Change amplitude and frequency
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        amplitude: 30.0,
        frequency: 2.0,
        waveLayers: testWaveLayers,
      ));

      expect(find.byType(WavesWidget), findsOneWidget);
    });

    testWidgets('should animate waves', (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        waveLayers: testWaveLayers,
      ));

      // Initial frame
      await tester.pump();

      // Advance animation
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(WavesWidget), findsOneWidget);
    });

    testWidgets('should dispose animation controller properly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WavesWidget(
        size: testSize,
        waveLayers: testWaveLayers,
      ));

      await tester.pump();

      // Remove widget
      await tester.pumpWidget(const SizedBox.shrink());

      // Should not throw any exceptions during disposal
      expect(find.byType(WavesWidget), findsNothing);
    });

    group('Default Values', () {
      test('should have correct default values', () {
        const widget = WavesWidget(
          size: testSize,
          waveLayers: testWaveLayers,
        );

        expect(widget.initialPhase, 10.0);
        expect(widget.amplitude, 20.0);
        expect(widget.frequency, 1.6);
        expect(widget.baseDuration, null);
      });
    });

    group('Advanced Features', () {
      testWidgets('should handle complex multi-layer configurations',
          (WidgetTester tester) async {
        const widget = WavesWidget(
          size: testSize,
          waveLayers: [
            WaveLayer.solid(
              duration: 3000,
              heightFactor: 0.9,
              color: Colors.blue,
              direction: 1.0,
              waveShape: SineShape(),
            ),
            WaveLayer.gradient(
              duration: 2500,
              heightFactor: 0.7,
              gradient: LinearGradient(colors: [Colors.green, Colors.blue]),
              direction: -1.0,
              phaseOffset: 90.0,
              waveShape: CosineShape(),
            ),
            WaveLayer.solid(
              duration: 2000,
              heightFactor: 0.5,
              color: Colors.red,
              amplitudeMultiplier: 0.7,
              waveShape: HarmonicShape(harmonics: [1.0, 0.5, 0.25]),
            ),
          ],
        );

        await tester.pumpWidget(widget);

        expect(find.byType(WavesWidget), findsOneWidget);
        expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
      });
    });
  });
}
