import 'mod.dart';

class Configuration {
  Plexity plexity;
  Similarity? similarity;
  Separability? separability;

  Configuration._(this.plexity, this.similarity, this.separability);

  static Configuration? from(
    Plexity plexity,
    Similarity? similarity,
    Separability? separability,
  ) {
    final ok = switch (plexity) {
      Plexity.u => similarity == null && separability == null,
      Plexity.d => (similarity == null) == (separability == null),
      Plexity.m => similarity != null && separability != null,
    };

    return ok ? Configuration._(plexity, similarity, separability) : null;
  }

  String romanize() {
    return switch (plexity) {
      Plexity.u => '',
      Plexity.d =>
        (similarity == null && separability == null)
            ? 's'
            : switch (similarity!) {
                Similarity.s => switch (separability!) {
                  Separability.s => 'c',
                  Separability.c => 'ks',
                  Separability.f => 'ps',
                },
                Similarity.d => switch (separability!) {
                  Separability.s => 'ţs',
                  Separability.c => 'fs',
                  Separability.f => 'š',
                },
                Similarity.f => switch (separability!) {
                  Separability.s => 'č',
                  Separability.c => 'kš',
                  Separability.f => 'pš',
                },
              },
      Plexity.m => switch (similarity!) {
        Similarity.s => switch (separability!) {
          Separability.s => 't',
          Separability.c => 'k',
          Separability.f => 'p',
        },
        Similarity.d => switch (separability!) {
          Separability.s => 'ţ',
          Separability.c => 'f',
          Separability.f => 'ç',
        },
        Similarity.f => switch (separability!) {
          Separability.s => 'z',
          Separability.c => 'ž',
          Separability.f => 'ẓ',
        },
      },
    };
  }
}
