/// Flutter Waves - A library for creating beautiful animated wave effects.
///
/// This library provides a comprehensive set of tools for creating animated
/// wave effects in Flutter applications. It includes customizable wave shapes,
/// layered wave rendering, and smooth animations.
/// ## Key Features:
/// - Multiple wave shapes (sine, cosine, square, triangle, etc.)
/// - Layered wave rendering with different colors and gradients
/// - Customizable animation timing and wave properties
/// - Advanced wave types like damped, harmonic, and Gerstner waves
/// - Composite waves for complex patterns
///
///  ## Basic Usage:
///  ```dart
///  import 'package:wave_widget/wave_widget.dart';
///
///  WavesWidget(
///   size: Size(400, 200),
///   waveLayers: [
///     WaveLayer.solid(
///       duration: 3000,
///       heightFactor: 0.8,
///       color: Colors.blue.withOpacity(0.6),
///     ),
///   ],
///  )
///  ```
library wave_widget;

export 'package:wave_widget/src/layers/wave_layer.dart';
export 'package:wave_widget/src/shapes/wave_shape.dart';
export 'package:wave_widget/src/waves_widget.dart';
