import 'case.dart';
import 'relation.dart';

sealed class ConcatenationStatus {
  const ConcatenationStatus();

  String id();

  String path();

  String idTopSecondary();
  String? idBottomSecondary();
  String pathTopSecondary();
  String? pathBottomSecondary();

  /// - `true`: This formative should use "case scope" in VnCn.
  /// - `false`: This formative should use "mood" in VnCn.
  bool isCaseScope();
}

class NoConcatenation extends ConcatenationStatus {
  final Relation relation;
  const NoConcatenation(this.relation);

  @override
  String id() => relation.id();

  @override
  String path() => relation.path();

  @override
  bool isCaseScope() => switch (relation) {
    Noun() => true,
    FramedVerb() => true,
    UnframedVerb() => false,
  };

  @override
  String idTopSecondary() => relation.idTopSecondary();

  @override
  String? idBottomSecondary() => relation.idBottomSecondary();

  @override
  String? pathBottomSecondary() => relation.pathBottomSecondary();

  @override
  String pathTopSecondary() => relation.pathTopSecondary();
}

class Type1Concatenation extends ConcatenationStatus {
  final Case format;

  const Type1Concatenation(this.format);

  @override
  String id() => "type_1_concatenation";

  @override
  String path() =>
      'M 5.00 -17.50 L -5.00 -7.50 -5.00 17.50 5.00 7.50 5.00 -17.50 Z';

  @override
  bool isCaseScope() => true;

  @override
  String idTopSecondary() => format.caseType.idSecondary();

  @override
  String? idBottomSecondary() => format.caseNumber.idSecondary();

  @override
  String pathTopSecondary() => format.caseType.pathSecondary();

  @override
  String? pathBottomSecondary() => format.caseNumber.pathSecondary();
}

class Type2Concatenation extends ConcatenationStatus {
  final Case format;

  const Type2Concatenation(this.format);

  @override
  String id() => "type_2_concatenation";

  @override
  String path() =>
      'M 7.60 0.00 L -1.20 8.80 0.00 10.00 20.00 -10.00 -10.00 -10.00 -20.00 0.00 7.60 0.00 Z';

  @override
  bool isCaseScope() => true;

  @override
  String idTopSecondary() => format.caseType.idSecondary();

  @override
  String? idBottomSecondary() => format.caseNumber.idSecondary();

  @override
  String pathTopSecondary() => format.caseType.pathSecondary();

  @override
  String? pathBottomSecondary() => format.caseNumber.pathSecondary();
}
