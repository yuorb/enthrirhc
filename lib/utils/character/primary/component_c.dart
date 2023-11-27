import '../../ithkuil/terms/separability.dart';
import '../../ithkuil/terms/similarity.dart';

class ComponentC {
  final Separability separability;
  final Similarity similarity;

  const ComponentC({
    required this.separability,
    required this.similarity,
  });

  String id() {
    return '${separability.name}_${similarity.name}';
  }

  String path() {
    return switch (similarity) {
      Similarity.s => switch (separability) {
          Separability.s => "M -32.50 12.50 L -12.50 32.50 -5.00 25.00 -25.00 5.00 -32.50 12.50 Z",
          Separability.c => "M -20.00 0.00 L -30.00 10.00 -30.00 35.00 -20.00 25.00 -20.00 0.00 Z",
          Separability.f => "M -10.00 30.00 L 0.00 20.00 -30.00 20.00 -40.00 30.00 -10.00 30.00 Z"
        },
      Similarity.d => switch (separability) {
          Separability.s =>
            "M -27.60 20.00 L -18.80 11.20 -20.00 10.00 -40.00 30.00 -10.00 30.00 0.00 20.00 -27.60 20.00 Z",
          Separability.c =>
            "M -20.00 27.60 L -11.20 18.80 -10.00 20.00 -30.00 40.00 -30.00 10.00 -20.00 0.00 -20.00 27.60 Z",
          Separability.f =>
            "M -35.85 22.50 Q -35.10 27.80 -30.45 30.90 -25.55 34.20 -17.50 34.10 L -10.00 26.60 Q -24.90 26.20 -28.60 18.05 -32.35 9.85 -21.15 1.15 L -22.40 0.00 Q -29.75 5.20 -33.30 11.40 -36.60 17.25 -35.85 22.50 Z"
        },
      Similarity.f => switch (separability) {
          Separability.s =>
            "M -10.75 21.70 Q -11.50 16.40 -16.15 13.30 -21.05 10.00 -29.10 10.10 L -36.60 17.60 Q -21.70 18.00 -18.00 26.15 -14.25 34.35 -25.45 43.05 L -24.20 44.20 Q -16.85 39.00 -13.30 32.80 -10.00 26.95 -10.75 21.70 Z",
          Separability.c =>
            "M -32.50 12.50 L -20.00 25.00 -35.00 25.00 -45.00 35.00 -15.00 35.00 -5.00 25.00 -25.00 5.00 -32.50 12.50 Z",
          Separability.f =>
            "M -33.30 11.40 Q -36.60 17.25 -35.85 22.50 -35.10 27.80 -30.45 30.90 -26.29 33.70 -19.85 34.05 L -28.70 42.90 -27.50 44.10 -10.00 26.60 Q -24.90 26.20 -28.60 18.05 -32.35 9.85 -21.15 1.15 L -22.40 0.00 Q -29.75 5.20 -33.30 11.40 Z"
        },
    };
  }
}
