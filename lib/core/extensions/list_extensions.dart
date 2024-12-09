extension ListEx<T> on List<T> {
  T? firstWhereOrNull(bool Function(dynamic) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  List<List<T>> groupBy<K>(K Function(T) keySelector) {
    final Map<K, List<T>> groupedMap = {};

    for (var element in this) {
      final key = keySelector(element);
      groupedMap.putIfAbsent(key, () => []).add(element);
    }

    return groupedMap.values.toList();
  }

  // sum of all elements in the list
  num sum() {
    if (T == num) {
      return fold(0, (previousValue, element) => previousValue + (element as num));
    } else {
      throw Exception('List must be of type num');
    }
  }

  // sum of all elements in the list * quantity
  num sumBy(num Function(T) selector) {
    return fold(0, (previousValue, element) => previousValue + selector(element));
  }

  // compare two lists
  bool equal(List<T> other) {
    if (length != other.length) return false;

    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }

    return true;
  }

  /// Replaces elements in the list that satisfy the given [test] with the result of applying the [replace] function to them.
  ///
  /// The [test] function should return `true` for elements that need to be replaced.
  /// The [replace] function takes an element as input and returns the replacement element.
  ///
  /// Example:
  /// ```dart
  /// List<int> numbers = [1, 2, 3, 4, 5];
  /// List<int> replacedNumbers = numbers.replaceWhere((number) => number % 2 == 0, (number) => number * 10);
  /// print(replacedNumbers); // Output: [1, 20, 3, 40, 5]
  /// ```
  ///
  /// Returns a new list with the replaced elements.
  List<T> replaceWhere(bool Function(T) test, T Function(T) replace) {
    return map((e) => test(e) ? replace(e) : e).toList();
  }
}

extension ListExt<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
