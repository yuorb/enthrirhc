sealed class Option<T> {
  const Option();

  static Option<T> from<T>(T? value) => value != null ? Some(value) : None<T>();

  bool isSome();
  bool isNone();
  T? into();
}

class Some<T> extends Option<T> {
  final T value;

  const Some(this.value);

  @override
  bool isSome() => true;

  @override
  bool isNone() => false;

  @override
  T? into() => value;
}

class None<T> extends Option<T> {
  const None();

  @override
  bool isSome() => false;

  @override
  bool isNone() => true;

  @override
  T? into() => null;
}
