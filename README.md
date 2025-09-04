# Wave Widget — Beautiful animated waves for Flutter

<p align="left">
  <a href="https://pub.dev/packages/wave_widget"><img src="https://img.shields.io/pub/v/wave_widget.svg" alt="Pub"></a>
  <a href="https://pub.dev/packages/wave_widget/score"><img src="https://img.shields.io/pub/likes/wave_widget?logo=dart" alt="Likes on pub.dev"></a>
  <a href="https://github.com/your-username/wave_widget"><img src="https://img.shields.io/github/stars/vanvixi/wave_widget.flutter.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>

Language: English | [Tiếng Việt](https://github.com/vanvixi/wave_widget.flutter/blob/main/README.vi.md)

A tiny, fast, and highly‑customizable Flutter widget for **beautiful animated waves**. Build calm AppBars or realistic
ocean scenes with layered rendering and smooth, precise animation control.

---

## ✨ Why Wave Widget?

- **Production‑ready performance** — CustomPainter‑based rendering with **low frame costs** (measured on macOS debug:
  *Raster ~2.5ms/frame*, *UI ~0.6ms/frame*).
- **Realistic water models** — Advanced **Gerstner waves** (deep water, shallow water, storm/turbulence), plus classic
  sine/cosine/triangle and harmonic blends.
- **Layered composition** — Stack multiple waves with independent color/gradient, height, duration, and shape for rich
  looks.
- **Type‑safe & flexible** — Pure Dart/Flutter API with clear enums and constructors.
- **Drop‑in simple** — Works in any widget tree; great for AppBars, hero banners, and animated backgrounds.

If you want to say thank you, star us on GitHub or like us on pub.dev.

<p align="center">
  <img src="https://raw.githubusercontent.com/vanvixi/waves/main/assets/demo.gif" alt="Flutter Waves demo" width="600"/>
</p>

## Use cases

| Scene              | Description                                          |
|--------------------|------------------------------------------------------|
| **Calm AppBar**    | A single soft sine wave under an app bar.            |
| **Gradient beach** | Two layered gradients with shallow‑water dispersion. |
| **Stormy ocean**   | Multi‑layer storm Gerstner with foam hints.          |

## Usage

First, follow the [package installation instructions](https://pub.dev/packages/waves/install) and add a `WavesWidget`
widget to your app:

### Basic Example

```dart
WavesWidget(
  size: const Size(400, 200),
  waveLayers: [
    WaveLayer.solid(
      duration: 3000,
      heightFactor: 0.8,
      color: Colors.blue.withOpacity(0.6),
    ),
  ],
)
```

## 🧩 Layered examples

```dart
WavesWidget(
  size: const Size(400, 300),
  amplitude: 25,
  frequency: 1.8,
  waveLayers: [
    WaveLayer.solid(
      duration: 3000,
      heightFactor: 0.8,
      color: Colors.blue.withOpacity(0.6),
      waveShape: WaveShape.sine,
    ),
    WaveLayer.gradient(
      duration: 2500,
      heightFactor: 0.6,
      gradient: LinearGradient(colors: [Colors.cyan, Colors.blue]),
      waveShape: WaveShape.cosine,
    ),
    WaveLayer.solid(
      duration: 4000,
      heightFactor: 0.4,
      color: Colors.lightBlue.withOpacity(0.3),
      waveShape: WaveShape.triangle,
    ),
  ],
)
```

## 🌊 Wave shapes

Realistic **Gerstner** families + classic shapes. Pick or mix:

```dart
// Realistic Gerstner (ocean-like crests)
WaveLayer.solid(
  waveShape: WaveShape.gerstner(steepness: 0.6),
  color: Colors.blue.withOpacity(0.7),
  duration: 3000,
);

// Deep water with dispersion
WaveLayer.gradient(
  waveShape: WaveShape.deepWaterGerstner(
    steepness: 0.4,
    depth: 1.2,
    windSpeed: 15,
  ),
  gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
  duration: 4000,
);

// Storm waves with turbulence + foam
WaveLayer.solid(
  waveShape: WaveShape.stormGerstner(
    steepness: 0.8,
    foamFactor: 0.4,
    turbulence: 0.6,
  ),
  color: Colors.indigo.shade900.withOpacity(0.8),
  duration: 2500,
);

// Harmonic overtones
WaveLayer.solid(
  waveShape: WaveShape.harmonic(harmonics: [1.0, 0.6, 0.3, 0.15]),
  color: Colors.teal,
  duration: 3500,
);
```

---

## ⚙️ Configuration

```dart
WavesWidget(
  size: const Size(400, 200),
  initialPhase: 10.0,   // starting phase offset
  amplitude: 20.0,      // wave height multiplier
  frequency: 1.6,       // wave density
  baseDuration: 3000,   // default animation duration for layers
  waveLayers: [ /* ... */ ],
)
```

**Layer types**
```dart
// Solid color
WaveLayer.solid(
  duration: 3000,
  heightFactor: 0.8,
  color: Colors.blue.withOpacity(0.6),
);

// Gradient
WaveLayer.gradient(
  duration: 2500,
  heightFactor: 0.6,
  gradient: LinearGradient(
    colors: [Colors.cyan, Colors.blue],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
```


## 🐳 Advanced recipes

### Deep ocean stack
```dart
WavesWidget(
  size: const Size(400, 300),
  amplitude: 35,
  frequency: 1.5,
  waveLayers: [
    WaveLayer.gradient(
      duration: 5000,
      heightFactor: 1.0,
      gradient: LinearGradient(
        colors: [
          Colors.indigo.withOpacity(0.4),
          Colors.deepPurple.withOpacity(0.6),
        ],
      ),
      waveShape: WaveShape.deepWaterGerstner(
        steepness: 0.3,
        depth: 1.5,
        windSpeed: 12,
      ),
    ),
    WaveLayer.solid(
      duration: 3500,
      heightFactor: 0.8,
      color: Colors.blue.withOpacity(0.5),
      waveShape: WaveShape.gerstner(steepness: 0.5),
    ),
    WaveLayer.gradient(
      duration: 2800,
      heightFactor: 0.6,
      gradient: LinearGradient(
        colors: [
          Colors.cyan.withOpacity(0.7),
          Colors.white.withOpacity(0.3),
        ],
      ),
      waveShape: WaveShape.stormGerstner(
        steepness: 0.7,
        foamFactor: 0.35,
        turbulence: 0.4,
      ),
    ),
    WaveLayer.solid(
      duration: 2000,
      heightFactor: 0.4,
      color: Colors.lightBlue.withOpacity(0.6),
      waveShape: WaveShape.harmonic(
        harmonics: [1.0, 0.5, 0.25, 0.125],
      ),
    ),
  ],
)
```

### Shallow water
```dart
WavesWidget(
  size: const Size(400, 200),
  amplitude: 20,
  frequency: 2.2,
  waveLayers: [
    WaveLayer.gradient(
      duration: 4200,
      heightFactor: 0.9,
      gradient: LinearGradient(
        colors: [
          Colors.teal.withOpacity(0.5),
          Colors.green.withOpacity(0.4),
        ],
      ),
      waveShape: WaveShape.shallowGerstner(
        steepness: 0.4,
        shoalingFactor: 1.3,
        bottomFriction: 0.15,
      ),
    ),
    WaveLayer.solid(
      duration: 3000,
      heightFactor: 0.6,
      color: Colors.lightGreen.withOpacity(0.6),
      waveShape: WaveShape.gerstner(steepness: 0.6),
    ),
  ],
)
```


## 📦 Example app

This package includes a **tabs-based demo** showcasing **four preset wave scenes**:

| Preset                | Description                                                 |
|-----------------------|-------------------------------------------------------------|
| **Deep Ocean**        | Deep-water Gerstner waves with dispersion and wind effects. |
| **Storm Waves**       | Dramatic storm conditions with foam hints and turbulence.   |
| **Shallow Water**     | Coastal waves with shoaling and bottom friction.            |
| **Multi-Directional** | Interference patterns from multiple wave directions.        |

See the source in [`example/lib/main.dart`](https://github.com/vanvixi/waves/blob/main/example/lib/main.dart) and run:

```bash
flutter run -d macos # or ios / android / web
```

## 🤝 Contributing

1. Fork the repo
2. Create a feature branch: `git checkout -b feat/awesome`
3. Commit: `git commit -m "feat: add awesome"`
4. Push: `git push origin feat/awesome`
5. Open a PR


## 📄 License

MIT — see [LICENSE](LICENSE).