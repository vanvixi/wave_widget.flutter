import 'package:flutter/material.dart';
import 'package:waves/waves.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: const Color(0xFF0173FD),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: WavesWidget(
            size: size,
            waveLayers: const [
              WaveLayer.gradient(
                duration: 32000,
                heightFactor: 0.405,
                direction: -0.6,
                phaseOffset: 0,
                amplitudeMultiplier: 1.4,
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 2.0,
                  colors: [
                    Color(0xFF0D47A1), // Navy blue
                    Color(0xFF01579B), // Darker navy
                    Color(0xFF263238), // Almost black
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
                waveShape: WaveShape.gerstner(),
              ),
              WaveLayer.gradient(
                duration: 21000,
                heightFactor: 0.375,
                direction: 0.8,
                phaseOffset: 120,
                amplitudeMultiplier: 1.1,
                gradient: RadialGradient(
                  center: Alignment(-0.4, -0.3),
                  radius: 1.5,
                  colors: [
                    Color(0xFF1565C0), // Brighter blue
                    Color(0xFF0D47A1), // Navy
                    Color(0xFF01579B), // Dark navy
                  ],
                  stops: [0.0, 0.6, 1.0],
                ),
                waveShape: WaveShape.gerstner(),
              ),
              WaveLayer.gradient(
                duration: 18000,
                heightFactor: 0.345,
                direction: -1.2,
                phaseOffset: 240,
                amplitudeMultiplier: 0.8,
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.8,
                  colors: [
                    Color(0xFF1976D2), // Ocean blue
                    Color(0xFF1565C0), // Deeper blue
                    Color(0xFF0D47A1), // Navy
                  ],
                  stops: [0.0, 0.4, 1.0],
                ),
                waveShape: WaveShape.gerstner(),
              ),
              WaveLayer.gradient(
                duration: 8000,
                heightFactor: 0.30,
                direction: 1.5,
                phaseOffset: 60,
                amplitudeMultiplier: 0.5,
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 2.2,
                  colors: [
                    Color(0xFFE3F2FD), // Foam white
                    Color(0xFF90CAF9), // Light blue
                    Color(0xFF42A5F5), // Ocean blue
                    Color(0xFF1976D2), // Deeper blue
                  ],
                  stops: [0.0, 0.2, 0.6, 1.0],
                ),
                waveShape: WaveShape.gerstner(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
