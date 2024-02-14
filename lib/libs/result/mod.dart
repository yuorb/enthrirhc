sealed class Result<T, E> {
  const Result();

  bool isOk();
  bool isErr();
  T unwrap();
  E unwrapErr();
}

class Ok<T, E> extends Result<T, E> {
  final T value;

  const Ok(this.value);

  @override
  bool isOk() => true;

  @override
  bool isErr() => false;

  @override
  T unwrap() => value;

  @override
  E unwrapErr() => throw "called `Result.unwrapErr()` on an `Ok` value: $value";
}

class Err<T, E> extends Result<T, E> {
  final E value;

  const Err(this.value);

  @override
  bool isOk() => false;

  @override
  bool isErr() => true;

  @override
  T unwrap() => throw 'called `Result.unwrap()` on an `Err` value: $value';

  @override
  E unwrapErr() => value;
}

Result<List<T>, E> collectResultList<T, E>(List<Result<T, E>> list) {
  final List<T> newList = List.empty(growable: true);
  for (final result in list) {
    switch (result) {
      case Ok(value: final value):
        newList.add(value);
        break;
      case Err(value: final err):
        return Err(err);
    }
  }
  return Ok(newList);
}
