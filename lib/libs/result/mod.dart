sealed class Result<T, E> {
  const Result();

  bool isOk();
  bool isErr();
  T unwrap();
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
}
