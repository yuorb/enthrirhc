import 'case.dart';
import 'concatenation.dart';
import 'relation.dart';

sealed class FormativeType {
  const FormativeType();

  String id();

  String path();

  /// - `true`: This formative should use case scope in VnCn.
  /// - `false`: This formative should use mood in VnCn.
  bool isCaseScope();
}

class Standalone extends FormativeType {
  final Relation relation;
  const Standalone(this.relation);

  @override
  String id() => relation.id();

  @override
  String path() => relation.path();

  @override
  bool isCaseScope() => switch (relation) {
        Noun() => true,
        FramedVerb() => false,
        UnframedVerb() => false,
      };
}

class Parent extends FormativeType {
  final Relation relation;
  const Parent(this.relation);

  @override
  String id() => relation.id();

  @override
  String path() => relation.path();

  @override
  bool isCaseScope() => switch (relation) {
        Noun() => true,
        FramedVerb() => false,
        UnframedVerb() => false,
      };
}

class Concatenated extends FormativeType {
  final Case format;
  final Concatenation concatenation;

  const Concatenated({
    required this.format,
    required this.concatenation,
  });

  @override
  String id() => "concatenation_${concatenation.name}";

  @override
  String path() => concatenation.path;

  @override
  bool isCaseScope() => true;
}
