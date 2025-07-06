import '../../terms/affiliation.dart';
import '../../terms/essence.dart';

class ComponentA {
  final Essence essence;
  final Affiliation affiliation;

  const ComponentA({required this.essence, required this.affiliation});

  String id() {
    return '${essence.name}_${affiliation.name}';
  }

  String path() {
    return switch (essence) {
      Essence.nrm => switch (affiliation) {
        Affiliation.csl => "",
        Affiliation.aso =>
          "M 5.00 -25.00 L 25.00 -5.00 32.50 -12.50 12.50 -32.50 5.00 -25.00 Z",
        Affiliation.coa =>
          "M 30.00 -20.00 L 40.00 -30.00 10.00 -30.00 0.00 -20.00 30.00 -20.00 Z",
        Affiliation.var$ =>
          "M 30.00 -35.00 L 20.00 -25.00 20.00 0.00 30.00 -10.00 30.00 -35.00 Z",
      },
      Essence.rpv => switch (affiliation) {
        Affiliation.csl =>
          "M 27.60 -20.00 L 18.80 -11.20 20.00 -10.00 40.00 -30.00 10.00 -30.00 0.00 -20.00 27.60 -20.00 Z",
        Affiliation.aso =>
          "M 30.00 -10.00 L 30.00 -35.00 10.00 -15.00 11.20 -13.80 20.00 -22.60 20.00 0.00 30.00 -10.00 Z",
        Affiliation.coa =>
          "M 10.75 -21.70 Q 11.50 -16.40 16.15 -13.30 21.05 -10.00 29.10 -10.10 L 36.60 -17.60 Q 21.70 -18.00 18.00 -26.15 14.25 -34.35 25.45 -43.05 L 24.20 -44.20 Q 16.85 -39.00 13.30 -32.80 10.00 -26.95 10.75 -21.70 Z",
        Affiliation.var$ =>
          "M 35.85 -22.50 Q 35.10 -27.80 30.45 -30.90 25.55 -34.20 17.50 -34.10 L 10.00 -26.60 Q 24.90 -26.20 28.60 -18.05 32.35 -9.85 21.15 -1.15 L 22.40 0.00 Q 29.75 -5.20 33.30 -11.40 36.60 -17.25 35.85 -22.50 Z",
      },
    };
  }
}
