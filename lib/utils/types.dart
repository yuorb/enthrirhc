import 'package:enthrirhc/libs/result/mod.dart';

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
  final String root;
  final List<Stem>? stems;
  final String? refers;
  final String? notes;
  final String? seeAlso;

  const Root({
    required this.root,
    this.refers,
    this.stems,
    this.notes,
    this.seeAlso,
  });

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
      seeAlso: data['see'],
    );
  }
}

sealed class Affix {
  const Affix();
}

enum GradientType {
  zero,
  a1,
  a2,
  b,
  c,
  d1,
  d2;

  static Result<GradientType, String> from(String str) {
    return switch (str) {
      "0" => const Ok(GradientType.zero),
      "A1" => const Ok(GradientType.a1),
      "A2" => const Ok(GradientType.a2),
      "B" => const Ok(GradientType.b),
      "C" => const Ok(GradientType.c),
      "D1" => const Ok(GradientType.d1),
      "D2" => const Ok(GradientType.d2),
      _ => Err('Invalid "gradient_type": $str'),
    };
  }
}

sealed class Degree {
  const Degree();

  static Result<Degree?, String> fromJson(dynamic source) {
    if (source == null) {
      return const Ok(null);
    }
    if (source is String) {
      return Ok(MergedDegree(source));
    }
    if (source is List<dynamic>) {
      final t1 = source[0];
      final t2 = source[1];
      if (t1 is! String) {
        return Err("Unexpected degree type-1 type: ${t1.runtimeType}");
      }
      if (t2 is! String) {
        return Err("Unexpected degree type-2 type: ${t2.runtimeType}");
      }
      return Ok(SeparatedDegree(t1, t2));
    }
    return Err("Unexpected degree type: ${source.runtimeType}");
  }
}

class MergedDegree extends Degree {
  final String degree;
  const MergedDegree(this.degree);

  String toJson() {
    return degree;
  }
}

class SeparatedDegree extends Degree {
  final String type1;
  final String type2;
  const SeparatedDegree(this.type1, this.type2);

  List<String> toJson() {
    return [type1, type2];
  }
}

class StandardAffix extends Affix {
  final String name;
  final String description;
  final GradientType gradientType;
  final String cs;
  final bool associatedRoot;
  final List<Degree?> degrees;
  final String? notes;

  const StandardAffix({
    required this.name,
    required this.description,
    required this.gradientType,
    required this.cs,
    required this.associatedRoot,
    required this.degrees,
    required this.notes,
  });

  static Result<StandardAffix, String> fromJson(Map<String, dynamic> data) {
    final gradientType1 = GradientType.from(data['gradient_type']);
    if (gradientType1.isErr()) {
      return Err(gradientType1.unwrapErr());
    }
    final gradientType2 = gradientType1.unwrap();
    final degrees1 = data['degrees'] as List<dynamic>;
    final degrees2 = degrees1.map((degree) => Degree.fromJson(degree)).toList();
    final degrees3 = collectResultList(degrees2);
    if (degrees3 is Err) {
      return Err(degrees3.unwrapErr());
    }
    final degrees4 = degrees3.unwrap();

    return Ok(StandardAffix(
      name: data['name'],
      description: data['description'],
      gradientType: gradientType2,
      cs: data['cs'],
      associatedRoot: data['associated_root'],
      degrees: degrees4,
      notes: data['notes'],
    ));
  }
}

class Case {
  final String cs;
  final List<String> vx;
  final String description;

  const Case({
    required this.cs,
    required this.vx,
    required this.description,
  });

  static Case fromJson(Map<String, dynamic> data) {
    final vx1 = data["vx"] as List;
    final vx2 = vx1.map((vx) => vx as String).toList();

    return Case(
      cs: data["cs"],
      vx: vx2,
      description: data["description"],
    );
  }
}

class CaseAccessorAffix extends Affix {
  final String name;
  final String description;
  final GradientType gradientType;
  final List<List<Case>> types;

  const CaseAccessorAffix({
    required this.name,
    required this.description,
    required this.gradientType,
    required this.types,
  });

  static Result<CaseAccessorAffix, String> fromJson(Map<String, dynamic> data) {
    final gradientType1 = GradientType.from(data["gradient_type"]);
    if (gradientType1 is Err) {
      return Err(gradientType1.unwrapErr());
    }
    final gradientType2 = gradientType1.unwrap();

    final types1 = data["types"] as List;
    final types2 =
        types1.map((t) => t as List).map((t) => t.map((c) => Case.fromJson(c)).toList()).toList();

    return Ok(CaseAccessorAffix(
      name: data["name"],
      description: data["description"],
      gradientType: gradientType2,
      types: types2,
    ));
  }
}

class CaseStackingAffix extends Affix {
  final String name;
  final String description;
  final GradientType gradientType;
  final List<Case> cases;

  const CaseStackingAffix({
    required this.name,
    required this.description,
    required this.gradientType,
    required this.cases,
  });

  static Result<CaseStackingAffix, String> fromJson(Map<String, dynamic> data) {
    final gradientType1 = GradientType.from(data["gradient_type"]);
    if (gradientType1 is Err) {
      return Err(gradientType1.unwrapErr());
    }
    final gradientType2 = gradientType1.unwrap();

    final cases1 = data["cases"] as List;
    final cases2 = cases1.map((c) => Case.fromJson(c)).toList();

    return Ok(CaseStackingAffix(
      name: data["name"],
      description: data["description"],
      gradientType: gradientType2,
      cases: cases2,
    ));
  }
}

class Lexicon {
  final List<Root> roots;
  final List<StandardAffix> standardAffixes;
  final List<CaseAccessorAffix> caseAccessorAffixes;
  final List<CaseStackingAffix> caseStackingAffixes;

  const Lexicon({
    required this.roots,
    required this.standardAffixes,
    required this.caseAccessorAffixes,
    required this.caseStackingAffixes,
  });

  static Result<Lexicon, String> fromJson(Map<String, dynamic> data) {
    final roots = (data['roots'] as List<dynamic>).map((e) => Root.fromJson(e)).toList();

    final standardAffixes1 = data['affixes']['standard'] as List<dynamic>;
    final standardAffixes2 = standardAffixes1.map((e) => StandardAffix.fromJson(e)).toList();
    final standardAffixes3 = collectResultList(standardAffixes2);
    if (standardAffixes3 is Err) {
      return Err(standardAffixes3.unwrapErr());
    }
    final standardAffixes4 = standardAffixes3.unwrap();

    final caseAccessorAffixes1 = data['affixes']['accessor'] as List;
    final caseAccessorAffixes2 =
        caseAccessorAffixes1.map((affix) => CaseAccessorAffix.fromJson(affix)).toList();
    final caseAccessorAffixes3 = collectResultList(caseAccessorAffixes2);
    if (caseAccessorAffixes3 is Err) {
      return Err(caseAccessorAffixes3.unwrapErr());
    }
    final caseAccessorAffixes4 = caseAccessorAffixes3.unwrap();

    final caseStackingAffixes1 = data['affixes']['stacking'] as List;
    final caseStackingAffixes2 =
        caseStackingAffixes1.map((affix) => CaseStackingAffix.fromJson(affix)).toList();
    final caseStackingAffixes3 = collectResultList(caseStackingAffixes2);
    if (caseStackingAffixes3 is Err) {
      return Err(caseStackingAffixes3.unwrapErr());
    }
    final caseStackingAffixes4 = caseStackingAffixes3.unwrap();

    return Ok(Lexicon(
      roots: roots,
      standardAffixes: standardAffixes4,
      caseAccessorAffixes: caseAccessorAffixes4,
      caseStackingAffixes: caseStackingAffixes4,
    ));
  }
}
