import 'case.dart';
import 'concatenation.dart';
import 'relation.dart';

sealed class FormativeType {
  const FormativeType();

  String id() {
    return switch (this) {
      Standalone(relation: final relation) => relation.id(),
      Parent(relation: final relation) => relation.id(),
      Concatenated(concatenation: final concatenation) => "concatenation_${concatenation.name}",
    };
  }

  String path() {
    return switch (this) {
      Standalone(relation: final relation) => relation.path(),
      Parent(relation: final relation) => relation.path(),
      Concatenated(concatenation: final concatenation) => concatenation.path,
    };
  }
}

class Standalone extends FormativeType {
  final Relation relation;
  const Standalone(this.relation);
}

class Parent extends FormativeType {
  final Relation relation;
  const Parent(this.relation);
}

class Concatenated extends FormativeType {
  final Case format;
  final Concatenation concatenation;

  const Concatenated({
    required this.format,
    required this.concatenation,
  });
}
