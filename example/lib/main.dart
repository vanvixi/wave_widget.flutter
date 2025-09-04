import 'package:flutter/material.dart';
import 'package:waves/waves.dart';

void main() {
  runApp(const WavesApp());
}

class WavesApp extends StatelessWidget {
  const WavesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Waves Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AdvancedWavesDemo(),
    );
  }
}

class AdvancedWavesDemo extends StatefulWidget {
  const AdvancedWavesDemo({super.key});

  @override
  State<AdvancedWavesDemo> createState() => _AdvancedWavesDemoState();
}

class _AdvancedWavesDemoState extends State<AdvancedWavesDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1428),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: const Color(0xFF1E293B),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.cyan,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.cyan,
          tabs: const [
            Tab(text: 'Deep Ocean'),
            Tab(text: 'Storm Waves'),
            Tab(text: 'Shallow Water'),
            Tab(text: 'Multi-Direction'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDeepOceanDemo(),
          _buildStormWavesDemo(),
          _buildShallowWaterDemo(),
          _buildMultiDirectionalDemo(),
        ],
      ),
    );
  }

  Widget _buildDeepOceanDemo() {
    return Column(
      children: [
        _buildInfoCard(
          'Deep Ocean Waves',
          'Realistic deep water physics with dispersion relation and wind effects',
          Colors.indigo,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F172A),
                  Color(0xFF1E293B),
                  Color(0xFF334155),
                ],
              ),
            ),
            child: WavesWidget(
              size: Size(MediaQuery.of(context).size.width, 400),
              amplitude: 40.0,
              frequency: 1.2,
              initialPhase: 0,
              waveLayers: const [
                // Deep ocean base layer - slow, rightward
                WaveLayer.gradient(
                  duration: 12000,
                  heightFactor: 1.0,
                  direction: 0.5,
                  phaseOffset: 0,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x60312E81),
                      Color(0x80475569),
                    ],
                  ),
                  waveShape: WaveShape.deepWaterGerstner(
                    steepness: 0.3,
                    depth: 2.0,
                    windSpeed: 15.0,
                  ),
                ),
                // Mid-deep layer - medium-slow, leftward
                WaveLayer.gradient(
                  duration: 10000,
                  heightFactor: 0.9,
                  direction: -0.6,
                  phaseOffset: 90,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x651E40AF),
                      Color(0x851565C0),
                    ],
                  ),
                  waveShape: WaveShape.deepWaterGerstner(
                    steepness: 0.35,
                    depth: 1.8,
                    windSpeed: 13.0,
                  ),
                ),
                // Mid-surface layer - medium speed, rightward
                WaveLayer.gradient(
                  duration: 7000,
                  heightFactor: 0.75,
                  direction: 0.9,
                  phaseOffset: 180,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x701976D2),
                      Color(0x901E3A8A),
                    ],
                  ),
                  waveShape: WaveShape.deepWaterGerstner(
                    steepness: 0.4,
                    depth: 1.3,
                    windSpeed: 10.0,
                  ),
                ),
                // Surface layer - fast, leftward
                WaveLayer.solid(
                  duration: 5000,
                  heightFactor: 0.6,
                  direction: -1.1,
                  phaseOffset: 270,
                  color: Color(0x80059669),
                  waveShape: WaveShape.gerstner(steepness: 0.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStormWavesDemo() {
    return Column(
      children: [
        _buildInfoCard(
          'Storm Waves',
          'Dramatic storm conditions with foam crests and chaotic turbulence',
          Colors.red,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF18181B),
                  Color(0xFF27272A),
                  Color(0xFF3F3F46),
                ],
              ),
            ),
            child: WavesWidget(
              size: Size(MediaQuery.of(context).size.width, 400),
              amplitude: 50.0,
              frequency: 1.8,
              initialPhase: 0,
              waveLayers: const [
                // Storm base layer - slow, chaotic rightward
                WaveLayer.gradient(
                  duration: 7500,
                  heightFactor: 1.0,
                  direction: 0.6,
                  phaseOffset: 0,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x60374151),
                      Color(0x80111827),
                    ],
                  ),
                  waveShape: WaveShape.stormGerstner(
                    steepness: 0.9,
                    foamFactor: 0.5,
                    turbulence: 0.7,
                  ),
                ),
                // Deep storm layer - medium-slow leftward
                WaveLayer.gradient(
                  duration: 6000,
                  heightFactor: 0.85,
                  direction: -0.8,
                  phaseOffset: 120,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x65525252),
                      Color(0x85262626),
                    ],
                  ),
                  waveShape: WaveShape.stormGerstner(
                    steepness: 0.85,
                    foamFactor: 0.45,
                    turbulence: 0.65,
                  ),
                ),
                // Chaotic mid-layer - fast rightward
                WaveLayer.solid(
                  duration: 4200,
                  heightFactor: 0.7,
                  direction: 1.0,
                  phaseOffset: 240,
                  color: Color(0x70DC2626),
                  waveShape: WaveShape.stormGerstner(
                    steepness: 0.8,
                    foamFactor: 0.4,
                    turbulence: 0.6,
                  ),
                ),
                // Foam layer - very fast leftward
                WaveLayer.gradient(
                  duration: 2800,
                  heightFactor: 0.55,
                  direction: -1.4,
                  phaseOffset: 300,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x80F8FAFC),
                      Color(0x60E2E8F0),
                    ],
                  ),
                  waveShape: WaveShape.stormGerstner(
                    steepness: 0.7,
                    foamFactor: 0.6,
                    turbulence: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShallowWaterDemo() {
    return Column(
      children: [
        _buildInfoCard(
          'Shallow Water Waves',
          'Coastal waves with shoaling effects and bottom friction',
          Colors.teal,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0C4A6E),
                  Color(0xFF0369A1),
                  Color(0xFF0284C7),
                ],
              ),
            ),
            child: WavesWidget(
              size: Size(MediaQuery.of(context).size.width, 400),
              amplitude: 35.0,
              frequency: 2.5,
              initialPhase: 0,
              waveLayers: const [
                // Shallow water base - slow toward shore
                WaveLayer.gradient(
                  duration: 4800,
                  heightFactor: 1.0,
                  direction: 0.4,
                  phaseOffset: 0,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x600D9488),
                      Color(0x800F766E),
                    ],
                  ),
                  waveShape: WaveShape.shallowGerstner(
                    steepness: 0.4,
                    shoalingFactor: 1.4,
                    bottomFriction: 0.15,
                  ),
                ),
                // Deep coastal layer - medium-slow back
                WaveLayer.gradient(
                  duration: 4200,
                  heightFactor: 0.85,
                  direction: -0.5,
                  phaseOffset: 90,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x65059669),
                      Color(0x85047857),
                    ],
                  ),
                  waveShape: WaveShape.shallowGerstner(
                    steepness: 0.35,
                    shoalingFactor: 1.3,
                    bottomFriction: 0.12,
                  ),
                ),
                // Mid coastal layer - moderate speed forward
                WaveLayer.solid(
                  duration: 3200,
                  heightFactor: 0.7,
                  direction: 0.8,
                  phaseOffset: 180,
                  color: Color(0x7014B8A6),
                  waveShape: WaveShape.shallowGerstner(
                    steepness: 0.3,
                    shoalingFactor: 1.2,
                    bottomFriction: 0.1,
                  ),
                ),
                // Surface layer - fast back
                WaveLayer.gradient(
                  duration: 2800,
                  heightFactor: 0.55,
                  direction: -1.0,
                  phaseOffset: 270,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x805EEAD4),
                      Color(0x6099F6E4),
                    ],
                  ),
                  waveShape: WaveShape.gerstner(steepness: 0.6),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultiDirectionalDemo() {
    return Column(
      children: [
        _buildInfoCard(
          'Multi-Directional Waves',
          'Complex interference patterns from multiple wave directions',
          Colors.purple,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1E1B4B),
                  Color(0xFF312E81),
                  Color(0xFF3730A3),
                ],
              ),
            ),
            child: WavesWidget(
              size: Size(MediaQuery.of(context).size.width, 400),
              amplitude: 42.0,
              frequency: 1.6,
              initialPhase: 0,
              waveLayers: const [
                // Multi-directional base - complex pattern
                WaveLayer.gradient(
                  duration: 5200,
                  heightFactor: 1.0,
                  direction: 0.3,
                  phaseOffset: 0,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x60581C87),
                      Color(0x80701A75),
                    ],
                  ),
                  waveShape: WaveShape.multiDirectionalGerstner(
                    steepness: 0.5,
                    directions: [
                      0.0,
                      0.785398,
                      -0.785398,
                      1.570796
                    ], // 0°, 45°, -45°, 90°
                    directionWeights: [1.0, 0.7, 0.5, 0.3],
                  ),
                ),
                // Secondary interference - medium-slow pattern
                WaveLayer.gradient(
                  duration: 4400,
                  heightFactor: 0.85,
                  direction: -0.4,
                  phaseOffset: 135,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x656366F1),
                      Color(0x854F46E5),
                    ],
                  ),
                  waveShape: WaveShape.multiDirectionalGerstner(
                    steepness: 0.45,
                    directions: [1.047198, -1.047198], // 60°, -60°
                    directionWeights: [0.9, 0.7],
                  ),
                ),
                // Complex interference layer - opposing direction
                WaveLayer.solid(
                  duration: 3400,
                  heightFactor: 0.7,
                  direction: 1.1,
                  phaseOffset: 240,
                  color: Color(0x707C3AED),
                  waveShape: WaveShape.multiDirectionalGerstner(
                    steepness: 0.4,
                    directions: [0.523599, -0.523599], // 30°, -30°
                    directionWeights: [0.8, 0.6],
                  ),
                ),
                // Surface complexity - fast harmonic
                WaveLayer.gradient(
                  duration: 2600,
                  heightFactor: 0.55,
                  direction: -1.3,
                  phaseOffset: 315,
                  gradient: LinearGradient(
                    colors: [
                      Color(0x80A855F7),
                      Color(0x60C084FC),
                    ],
                  ),
                  waveShape: WaveShape.harmonic(
                    harmonics: [1.0, 0.6, 0.3, 0.15],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String description, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
