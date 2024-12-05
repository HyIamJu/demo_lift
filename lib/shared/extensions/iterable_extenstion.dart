extension IterableExt<T> on Iterable<T> {
  T? get secondToLast {
    return length < 2 ? null : elementAt(length - 2);
  }
}
