class Specs {
  Specs(this.bsc, this.cte, this.csv, this.obj);

  final String bsc;
  final String cte;
  final String csv;
  final String obj;

  factory Specs.fromJson(Map<String, String> data) {
    final bsc = data['BSC']!;
    final cte = data['CTE']!;
    final csv = data['CSV']!;
    final obj = data['OBJ']!;
    return Specs(bsc, cte, csv, obj);
  }
}

class Root {
  Root({required this.root, this.refers, this.stems, this.notes, this.see});

  final String root;
  final String? refers;
  final dynamic stems;
  final String? notes;
  final String? see;

  factory Root.fromJson(Map<String, dynamic> data) {
    final root = data['root'];
    final refers = data['refers'];
    final stems = data['stems'];
    final notes = data['notes'];
    final see = data['see'];

    return Root(
      root: root,
      refers: refers,
      stems: stems,
      notes: notes,
      see: see,
    );
  }
}
