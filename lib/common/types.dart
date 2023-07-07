sealed class Stem {
  const Stem();

  factory Stem.from(dynamic stem) {
    if (stem is String) {
      return StrStem(stem);
    } else {
      assert(stem is Map<String, dynamic>);
      return Specs.fromJson(stem);
    }
  }
}

class Specs extends Stem {
  const Specs(this.bsc, this.cte, this.csv, this.obj);

  final String bsc;
  final String cte;
  final String csv;
  final String obj;

  factory Specs.fromJson(Map<String, dynamic> data) {
    final bsc = data['BSC'];
    final cte = data['CTE'];
    final csv = data['CSV'];
    final obj = data['OBJ'];
    return Specs(bsc, cte, csv, obj);
  }

  Map<String, dynamic> toJson() {
    return {
      'BSC': bsc,
      'CTE': cte,
      'CSV': csv,
      'OBJ': obj,
    };
  }
}

class StrStem extends Stem {
  final String value;
  const StrStem(this.value);

  String toJson() {
    return value;
  }
}

class Root {
  const Root({
    required this.root,
    this.refers,
    this.stems,
    this.notes,
    this.see,
  });

  final String root;
  final List<Stem>? stems;
  final String? refers;
  final String? notes;
  final String? see;

  factory Root.fromJson(Map<String, dynamic> data) {
    final List<Stem>? stems;
    if (data['stems'] != null) {
      final List<dynamic> stemsMap = data['stems'];
      stems =
          stemsMap.map((stem) => stem is String ? StrStem(stem) : Specs.fromJson(stem)).toList();
    } else {
      stems = null;
    }

    return Root(
      root: data['root'],
      refers: data['refers'],
      stems: stems,
      notes: data['notes'],
      see: data['see'],
    );
  }
}
