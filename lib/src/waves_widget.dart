import 'package:flutter/widgets.dart';

import 'consts.dart';
import 'layers/wave_layer.dart';
import 'waves_painter.dart';

/// A Flutter widget that renders animated wave effects.
///
/// The [WavesWidget] combines multiple [WaveLayer]s to create complex
/// animated wave patterns. Each layer can have different visual properties,
/// animation durations, and wave shapes, allowing for rich layered effects.
///
/// Example usage:
/// ```dart
/// WavesWidget(
///   size: Size(400, 200),
///   waveLayers: [
///     WaveLayer.solid(
///       duration: 3000,
///       heightFactor: 0.8,
///       color: Colors.blue.withOpacity(0.6),
///     ),
///     WaveLayer.gradient(
///       duration: 2500,
///       heightFactor: 0.6,
///       gradient: LinearGradient(
///         colors: [Colors.cyan, Colors.blue],
///       ),
///     ),
///   ],
/// )
/// ```
class WavesWidget extends StatefulWidget {
  /// Creates a waves widget with customizable wave properties.
  ///
  /// [size] - The size of the wave canvas
  /// [initialPhase] - Initial phase offset for the wave animation (default: 10.0)
  /// [amplitude] - Base amplitude for wave height (default: 20.0)
  /// [frequency] - Wave frequency affecting wave density (default: 1.6)
  /// [baseDuration] - Override base animation duration (optional)
  /// [waveLayers] - List of wave layers to render
  const WavesWidget({
    super.key,
    required this.size,
    this.initialPhase = 10.0,
    this.amplitude = 20.0,
    this.frequency = 1.6,
    this.baseDuration,
    required this.waveLayers,
  });

  /// The size of the wave rendering canvas
  final Size size;

  /// Initial phase offset in degrees for wave positioning
  final double initialPhase;

  /// Base amplitude controlling overall wave height
  final double amplitude;

  /// Wave frequency affecting the density of wave cycles
  final double frequency;

  /// Optional override for base animation duration in milliseconds
  final int? baseDuration;

  /// List of wave layers to render, drawn in order from first to last
  final List<WaveLayer> waveLayers;

  @override
  State<WavesWidget> createState() => _WavesWidgetState();
}

class _WavesWidgetState extends State<WavesWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int baseDuration;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WavesWidget oldWidget) {
    if (oldWidget.size != widget.size ||
        oldWidget.waveLayers != widget.waveLayers ||
        oldWidget.initialPhase != widget.initialPhase ||
        oldWidget.amplitude != widget.amplitude ||
        oldWidget.frequency != widget.frequency) {
      _reinitialize();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _reinitialize() {
    _controller.dispose();
    _initAnimation();
  }

  void _initAnimation() {
    if (widget.waveLayers.isEmpty) {
      throw ArgumentError("waveLayers must not be empty");
    }

    baseDuration = widget.baseDuration ??
        widget.waveLayers
            .map((layer) => layer.duration)
            .reduce((a, b) => a < b ? a : b);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: baseDuration),
    );

    _animation = Tween<double>(
      begin: widget.initialPhase,
      end: kDegreesInFullCircle + widget.initialPhase,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          _controller.reverse();
          break;
        case AnimationStatus.dismissed:
          _controller.forward();
          break;
        default:
          break;
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: widget.size,
        painter: WavesPainter(
          baseDuration: baseDuration,
          amplitude: widget.amplitude,
          frequency: widget.frequency,
          layers: widget.waveLayers,
          animation: _animation,
        ),
      ),
    );
  }
}
