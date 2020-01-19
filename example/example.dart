// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Tests some basic functionality of instance mirrors and class mirrors.

library test_reflectable.test.basic_test;

import 'package:reflectable/reflectable.dart' as r;
import 'package:reflectable/capability.dart';

class MyReflectable extends r.Reflectable {
  const MyReflectable()
      : super(
          staticInvokeCapability,
          instanceInvokeCapability,
          newInstanceCapability,
          declarationsCapability,
        );
}

@MyReflectable()
abstract class List<E> implements EfficientLengthIterable<E> {
  /**
   * Creates a list of the given length.
   *
   * The created list is fixed-length if [length] is provided.
   *
   *     List fixedLengthList = new List(3);
   *     fixedLengthList.length;     // 3
   *     fixedLengthList.length = 1; // Error
   *
   * The list has length 0 and is growable if [length] is omitted.
   *
   *     List growableList = new List();
   *     growableList.length; // 0;
   *     growableList.length = 3;
   *
   * To create a growable list with a given length, just assign the length
   * right after creation:
   *
   *     List growableList = new List()..length = 500;
   *
   * The [length] must not be negative or null, if it is provided.
   */
  external factory List([int length]);

  /**
   * Creates a list of the given length with [fill] at each position.
   *
   * The [length] must be a non-negative integer.
   *
   * Example:
   * ```dart
   * new List<int>.filled(3, 0, growable: true); // [0, 0, 0]
   * ```
   *
   * The created list is fixed-length if [growable] is false (the default)
   * and growable if [growable] is true.
   * If the list is growable, changing its length will not initialize new
   * entries with [fill].
   * After being created and filled, the list is no different from any other
   * growable or fixed-length list created using [List].
   *
   * All elements of the returned list share the same [fill] value.
   * ```
   * var shared = new List.filled(3, []);
   * shared[0].add(499);
   * print(shared);  // => [[499], [499], [499]]
   * ```
   *
   * You can use [List.generate] to create a list with a new object at
   * each position.
   * ```
   * var unique = new List.generate(3, (_) => []);
   * unique[0].add(499);
   * print(unique); // => [[499], [], []]
   * ```
   */
  external factory List.filled(int length, E fill, {bool growable = false});

  /**
   * Creates a list containing all [elements].
   *
   * The [Iterator] of [elements] provides the order of the elements.
   *
   * All the [elements] should be instances of [E].
   * The `elements` iterable itself may have any element type, so this
   * constructor can be used to down-cast a `List`, for example as:
   * ```dart
   * List<SuperType> superList = ...;
   * List<SubType> subList =
   *     new List<SubType>.from(superList.whereType<SubType>());
   * ```
   *
   * This constructor creates a growable list when [growable] is true;
   * otherwise, it returns a fixed-length list.
   */
  external factory List.from(Iterable elements, {bool growable = true});

  /**
   * Creates a list from [elements].
   *
   * The [Iterator] of [elements] provides the order of the elements.
   *
   * This constructor creates a growable list when [growable] is true;
   * otherwise, it returns a fixed-length list.
   */
  factory List.of(Iterable<E> elements, {bool growable = true}) =>
      List<E>.from(elements, growable: growable);

  /**
   * Generates a list of values.
   *
   * Creates a list with [length] positions and fills it with values created by
   * calling [generator] for each index in the range `0` .. `length - 1`
   * in increasing order.
   *
   *     new List<int>.generate(3, (int index) => index * index); // [0, 1, 4]
   *
   * The created list is fixed-length unless [growable] is true.
   */
  factory List.generate(int length, E generator(int index),
      {bool growable = true}) {
    List<E> result;
    if (growable) {
      result = <E>[]..length = length;
    } else {
      result = List<E>(length);
    }
    for (int i = 0; i < length; i++) {
      result[i] = generator(i);
    }
    return result;
  }

  /**
   * Creates an unmodifiable list containing all [elements].
   *
   * The [Iterator] of [elements] provides the order of the elements.
   *
   * An unmodifiable list cannot have its length or elements changed.
   * If the elements are themselves immutable, then the resulting list
   * is also immutable.
   */
  external factory List.unmodifiable(Iterable elements);

  /**
   * Adapts [source] to be a `List<T>`.
   *
   * Any time the list would produce an element that is not a [T],
   * the element access will throw.
   *
   * Any time a [T] value is attempted stored into the adapted list,
   * the store will throw unless the value is also an instance of [S].
   *
   * If all accessed elements of [source] are actually instances of [T],
   * and if all elements stored into the returned list are actually instance
   * of [S],
   * then the returned list can be used as a `List<T>`.
   */
  static List<T> castFrom<S, T>(List<S> source) => CastList<S, T>(source);

  /**
   * Copy a range of one list into another list.
   *
   * This is a utility function that can be used to implement methods like
   * [setRange].
   *
   * The range from [start] to [end] must be a valid range of [source],
   * and there must be room for `end - start` elements from position [at].
   * If [start] is omitted, it defaults to zero.
   * If [end] is omitted, it defaults to [source.length].
   *
   * If [source] and [target] is the same list, overlapping source and target
   * ranges are respected so that the target range ends up containing the
   * initial content of the source range.
   * Otherwise the order of element copying is not guaranteed.
   */
  static void copyRange<T>(List<T> target, int at, List<T> source,
      [int start, int end]) {
    start ??= 0;
    end = RangeError.checkValidRange(start, end, source.length);
    int length = end - start;
    if (target.length < at + length) {
      throw ArgumentError.value(target, "target",
          "Not big enough to hold $length elements at position $at");
    }
    if (!identical(source, target) || start >= at) {
      for (int i = 0; i < length; i++) {
        target[at + i] = source[start + i];
      }
    } else {
      for (int i = length; --i >= 0;) {
        target[at + i] = source[start + i];
      }
    }
  }

  /**
   * Write the elements of an iterable into a list.
   *
   * This is a utility function that can be used to implement methods like
   * [setAll].
   *
   * The elements of [source] are written into [target] from position [at].
   * The [source] must not contain more elements after writing the last
   * position of [target].
   *
   * If the source is a list, the [copyRange] function is likely to be more
   * efficient.
   */
  static void writeIterable<T>(List<T> target, int at, Iterable<T> source) {
    RangeError.checkValueInInterval(at, 0, target.length, "at");
    int index = at;
    int targetLength = target.length;
    for (var element in source) {
      if (index == targetLength) {
        throw IndexError(targetLength, target);
      }
      target[index] = element;
      index++;
    }
  }

  /**
   * Returns a view of this list as a list of [R] instances.
   *
   * If this list contains only instances of [R], all read operations
   * will work correctly. If any operation tries to access an element
   * that is not an instance of [R], the access will throw instead.
   *
   * Elements added to the list (e.g., by using [add] or [addAll])
   * must be instance of [R] to be valid arguments to the adding function,
   * and they must be instances of [E] as well to be accepted by
   * this list as well.
   *
   * Typically implemented as `List.castFrom<E, R>(this)`.
   */
  List<R> cast<R>();
  /**
   * Returns the object at the given [index] in the list
   * or throws a [RangeError] if [index] is out of bounds.
   */
  E operator [](int index);

  /**
   * Sets the value at the given [index] in the list to [value]
   * or throws a [RangeError] if [index] is out of bounds.
   */
  void operator []=(int index, E value);

  /**
   * Updates the first position of the list to contain [value].
   *
   * Equivalent to `theList[0] = value;`.
   *
   * The list must be non-empty.
   */
  void set first(E value);

  /**
   * Updates the last position of the list to contain [value].
   *
   * Equivalent to `theList[theList.length - 1] = value;`.
   *
   * The list must be non-empty.
   */
  void set last(E value);

  /**
   * Returns the number of objects in this list.
   *
   * The valid indices for a list are `0` through `length - 1`.
   */
  int get length;

  /**
   * Changes the length of this list.
   *
   * If [newLength] is greater than
   * the current length, entries are initialized to [:null:].
   *
   * Throws an [UnsupportedError] if the list is fixed-length.
   */
  set length(int newLength);

  /**
   * Adds [value] to the end of this list,
   * extending the length by one.
   *
   * Throws an [UnsupportedError] if the list is fixed-length.
   */
  void add(E value);

  /**
   * Appends all objects of [iterable] to the end of this list.
   *
   * Extends the length of the list by the number of objects in [iterable].
   * Throws an [UnsupportedError] if this list is fixed-length.
   */
  void addAll(Iterable<E> iterable);

  /**
   * Returns an [Iterable] of the objects in this list in reverse order.
   */
  Iterable<E> get reversed;

  /**
   * Sorts this list according to the order specified by the [compare] function.
   *
   * The [compare] function must act as a [Comparator].
   *
   *     List<String> numbers = ['two', 'three', 'four'];
   *     // Sort from shortest to longest.
   *     numbers.sort((a, b) => a.length.compareTo(b.length));
   *     print(numbers);  // [two, four, three]
   *
   * The default List implementations use [Comparable.compare] if
   * [compare] is omitted.
   *
   *     List<int> nums = [13, 2, -11];
   *     nums.sort();
   *     print(nums);  // [-11, 2, 13]
   *
   * A [Comparator] may compare objects as equal (return zero), even if they
   * are distinct objects.
   * The sort function is not guaranteed to be stable, so distinct objects
   * that compare as equal may occur in any order in the result:
   *
   *     List<String> numbers = ['one', 'two', 'three', 'four'];
   *     numbers.sort((a, b) => a.length.compareTo(b.length));
   *     print(numbers);  // [one, two, four, three] OR [two, one, four, three]
   */
  void sort([int compare(E a, E b)]);

  /**
   * Shuffles the elements of this list randomly.
   */
  void shuffle([Random random]);

  /**
   * Returns the first index of [element] in this list.
   *
   * Searches the list from index [start] to the end of the list.
   * The first time an object [:o:] is encountered so that [:o == element:],
   * the index of [:o:] is returned.
   *
   *     List<String> notes = ['do', 're', 'mi', 're'];
   *     notes.indexOf('re');    // 1
   *     notes.indexOf('re', 2); // 3
   *
   * Returns -1 if [element] is not found.
   *
   *     notes.indexOf('fa');    // -1
   */
  int indexOf(E element, [int start = 0]);

  /**
   * Returns the first index in the list that satisfies the provided [test].
   *
   * Searches the list from index [start] to the end of the list.
   * The first time an object `o` is encountered so that `test(o)` is true,
   * the index of `o` is returned.
   *
   * ```
   * List<String> notes = ['do', 're', 'mi', 're'];
   * notes.indexWhere((note) => note.startsWith('r'));       // 1
   * notes.indexWhere((note) => note.startsWith('r'), 2);    // 3
   * ```
   *
   * Returns -1 if [element] is not found.
   * ```
   * notes.indexWhere((note) => note.startsWith('k'));    // -1
   * ```
   */
  int indexWhere(bool test(E element), [int start = 0]);

  /**
   * Returns the last index in the list that satisfies the provided [test].
   *
   * Searches the list from index [start] to 0.
   * The first time an object `o` is encountered so that `test(o)` is true,
   * the index of `o` is returned.
   *
   * ```
   * List<String> notes = ['do', 're', 'mi', 're'];
   * notes.lastIndexWhere((note) => note.startsWith('r'));       // 3
   * notes.lastIndexWhere((note) => note.startsWith('r'), 2);    // 1
   * ```
   *
   * Returns -1 if [element] is not found.
   * ```
   * notes.lastIndexWhere((note) => note.startsWith('k'));    // -1
   * ```
   */
  int lastIndexWhere(bool test(E element), [int start]);

  /**
   * Returns the last index of [element] in this list.
   *
   * Searches the list backwards from index [start] to 0.
   *
   * The first time an object [:o:] is encountered so that [:o == element:],
   * the index of [:o:] is returned.
   *
   *     List<String> notes = ['do', 're', 'mi', 're'];
   *     notes.lastIndexOf('re', 2); // 1
   *
   * If [start] is not provided, this method searches from the end of the
   * list./Returns
   *
   *     notes.lastIndexOf('re');  // 3
   *
   * Returns -1 if [element] is not found.
   *
   *     notes.lastIndexOf('fa');  // -1
   */
  int lastIndexOf(E element, [int start]);

  /**
   * Removes all objects from this list;
   * the length of the list becomes zero.
   *
   * Throws an [UnsupportedError], and retains all objects, if this
   * is a fixed-length list.
   */
  void clear();

  /**
   * Inserts the object at position [index] in this list.
   *
   * This increases the length of the list by one and shifts all objects
   * at or after the index towards the end of the list.
   *
   * An error occurs if the [index] is less than 0 or greater than length.
   * An [UnsupportedError] occurs if the list is fixed-length.
   */
  void insert(int index, E element);

  /**
   * Inserts all objects of [iterable] at position [index] in this list.
   *
   * This increases the length of the list by the length of [iterable] and
   * shifts all later objects towards the end of the list.
   *
   * An error occurs if the [index] is less than 0 or greater than length.
   * An [UnsupportedError] occurs if the list is fixed-length.
   */
  void insertAll(int index, Iterable<E> iterable);

  /**
   * Overwrites objects of `this` with the objects of [iterable], starting
   * at position [index] in this list.
   *
   *     List<String> list = ['a', 'b', 'c'];
   *     list.setAll(1, ['bee', 'sea']);
   *     list.join(', '); // 'a, bee, sea'
   *
   * This operation does not increase the length of `this`.
   *
   * The [index] must be non-negative and no greater than [length].
   *
   * The [iterable] must not have more elements than what can fit from [index]
   * to [length].
   *
   * If `iterable` is based on this list, its values may change /during/ the
   * `setAll` operation.
   */
  void setAll(int index, Iterable<E> iterable);

  /**
   * Removes the first occurrence of [value] from this list.
   *
   * Returns true if [value] was in the list, false otherwise.
   *
   *     List<String> parts = ['head', 'shoulders', 'knees', 'toes'];
   *     parts.remove('head'); // true
   *     parts.join(', ');     // 'shoulders, knees, toes'
   *
   * The method has no effect if [value] was not in the list.
   *
   *     // Note: 'head' has already been removed.
   *     parts.remove('head'); // false
   *     parts.join(', ');     // 'shoulders, knees, toes'
   *
   * An [UnsupportedError] occurs if the list is fixed-length.
   */
  bool remove(Object value);

  /**
   * Removes the object at position [index] from this list.
   *
   * This method reduces the length of `this` by one and moves all later objects
   * down by one position.
   *
   * Returns the removed object.
   *
   * The [index] must be in the range `0 ≤ index < length`.
   *
   * Throws an [UnsupportedError] if this is a fixed-length list. In that case
   * the list is not modified.
   */
  E removeAt(int index);

  /**
   * Pops and returns the last object in this list.
   *
   * Throws an [UnsupportedError] if this is a fixed-length list.
   */
  E removeLast();

  /**
   * Removes all objects from this list that satisfy [test].
   *
   * An object [:o:] satisfies [test] if [:test(o):] is true.
   *
   *     List<String> numbers = ['one', 'two', 'three', 'four'];
   *     numbers.removeWhere((item) => item.length == 3);
   *     numbers.join(', '); // 'three, four'
   *
   * Throws an [UnsupportedError] if this is a fixed-length list.
   */
  void removeWhere(bool test(E element));

  /**
   * Removes all objects from this list that fail to satisfy [test].
   *
   * An object [:o:] satisfies [test] if [:test(o):] is true.
   *
   *     List<String> numbers = ['one', 'two', 'three', 'four'];
   *     numbers.retainWhere((item) => item.length == 3);
   *     numbers.join(', '); // 'one, two'
   *
   * Throws an [UnsupportedError] if this is a fixed-length list.
   */
  void retainWhere(bool test(E element));

  /**
   * Returns the concatenation of this list and [other].
   *
   * Returns a new list containing the elements of this list followed by
   * the elements of [other].
   *
   * The default behavior is to return a normal growable list.
   * Some list types may choose to return a list of the same type as themselves
   * (see [Uint8List.+]);
   */
  List<E> operator +(List<E> other);

  /**
   * Returns a new list containing the elements between [start] and [end].
   *
   * The new list is a `List<E>` containing the elements of this list at
   * positions greater than or equal to [start] and less than [end] in the same
   * order as they occur in this list.
   *
   * ```dart
   * var colors = ["red", "green", "blue", "orange", "pink"];
   * print(colors.sublist(1, 3)); // [green, blue]
   * ```
   *
   * If [end] is omitted, it defaults to the [length] of this list.
   *
   * ```dart
   * print(colors.sublist(1)); // [green, blue, orange, pink]
   * ```
   *
   * The `start` and `end` positions must satisfy the relations
   * 0 ≤ `start` ≤ `end` ≤ `this.length`
   * If `end` is equal to `start`, then the returned list is empty.
   */
  List<E> sublist(int start, [int end]);

  /**
   * Returns an [Iterable] that iterates over the objects in the range
   * [start] inclusive to [end] exclusive.
   *
   * The provided range, given by [start] and [end], must be valid at the time
   * of the call.
   *
   * A range from [start] to [end] is valid if `0 <= start <= end <= len`, where
   * `len` is this list's `length`. The range starts at `start` and has length
   * `end - start`. An empty range (with `end == start`) is valid.
   *
   * The returned [Iterable] behaves like `skip(start).take(end - start)`.
   * That is, it does *not* throw if this list changes size.
   *
   *     List<String> colors = ['red', 'green', 'blue', 'orange', 'pink'];
   *     Iterable<String> range = colors.getRange(1, 4);
   *     range.join(', ');  // 'green, blue, orange'
   *     colors.length = 3;
   *     range.join(', ');  // 'green, blue'
   */
  Iterable<E> getRange(int start, int end);

  /**
   * Copies the objects of [iterable], skipping [skipCount] objects first,
   * into the range [start], inclusive, to [end], exclusive, of the list.
   *
   *     List<int> list1 = [1, 2, 3, 4];
   *     List<int> list2 = [5, 6, 7, 8, 9];
   *     // Copies the 4th and 5th items in list2 as the 2nd and 3rd items
   *     // of list1.
   *     list1.setRange(1, 3, list2, 3);
   *     list1.join(', '); // '1, 8, 9, 4'
   *
   * The provided range, given by [start] and [end], must be valid.
   * A range from [start] to [end] is valid if `0 <= start <= end <= len`, where
   * `len` is this list's `length`. The range starts at `start` and has length
   * `end - start`. An empty range (with `end == start`) is valid.
   *
   * The [iterable] must have enough objects to fill the range from `start`
   * to `end` after skipping [skipCount] objects.
   *
   * If `iterable` is this list, the operation copies the elements
   * originally in the range from `skipCount` to `skipCount + (end - start)` to
   * the range `start` to `end`, even if the two ranges overlap.
   *
   * If `iterable` depends on this list in some other way, no guarantees are
   * made.
   */
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]);

  /**
   * Removes the objects in the range [start] inclusive to [end] exclusive.
   *
   * The provided range, given by [start] and [end], must be valid.
   * A range from [start] to [end] is valid if `0 <= start <= end <= len`, where
   * `len` is this list's `length`. The range starts at `start` and has length
   * `end - start`. An empty range (with `end == start`) is valid.
   *
   * Throws an [UnsupportedError] if this is a fixed-length list. In that case
   * the list is not modified.
   */
  void removeRange(int start, int end);

  /**
   * Sets the objects in the range [start] inclusive to [end] exclusive
   * to the given [fillValue].
   *
   * The provided range, given by [start] and [end], must be valid.
   * A range from [start] to [end] is valid if `0 <= start <= end <= len`, where
   * `len` is this list's `length`. The range starts at `start` and has length
   * `end - start`. An empty range (with `end == start`) is valid.
   */
  void fillRange(int start, int end, [E fillValue]);

  /**
   * Removes the objects in the range [start] inclusive to [end] exclusive
   * and inserts the contents of [replacement] in its place.
   *
   *     List<int> list = [1, 2, 3, 4, 5];
   *     list.replaceRange(1, 4, [6, 7]);
   *     list.join(', '); // '1, 6, 7, 5'
   *
   * The provided range, given by [start] and [end], must be valid.
   * A range from [start] to [end] is valid if `0 <= start <= end <= len`, where
   * `len` is this list's `length`. The range starts at `start` and has length
   * `end - start`. An empty range (with `end == start`) is valid.
   *
   * This method does not work on fixed-length lists, even when [replacement]
   * has the same number of elements as the replaced range. In that case use
   * [setRange] instead.
   */
  void replaceRange(int start, int end, Iterable<E> replacement);

  /**
   * Returns an unmodifiable [Map] view of `this`.
   *
   * The map uses the indices of this list as keys and the corresponding objects
   * as values. The `Map.keys` [Iterable] iterates the indices of this list
   * in numerical order.
   *
   *     List<String> words = ['fee', 'fi', 'fo', 'fum'];
   *     Map<int, String> map = words.asMap();
   *     map[0] + map[1];   // 'feefi';
   *     map.keys.toList(); // [0, 1, 2, 3]
   */
  Map<int, E> asMap();
}

@MyReflectable()
@immutable
class TextTheme extends Diagnosticable {
  /// Creates a text theme that uses the given values.
  ///
  /// Rather than creating a new text theme, consider using [Typography.black]
  /// or [Typography.white], which implement the typography styles in the
  /// material design specification:
  ///
  /// <https://material.io/design/typography/#type-scale>
  ///
  /// If you do decide to create your own text theme, consider using one of
  /// those predefined themes as a starting point for [copyWith] or [apply].
  const TextTheme({
    this.display4,
    this.display3,
    this.display2,
    this.display1,
    this.headline,
    this.title,
    this.subhead,
    this.body2,
    this.body1,
    this.caption,
    this.button,
    this.subtitle,
    this.overline,
  });

  /// Extremely large text.
  ///
  /// The font size is 112 pixels.
  final TextStyle display4;

  /// Very, very large text.
  ///
  /// Used for the date in the dialog shown by [showDatePicker].
  final TextStyle display3;

  /// Very large text.
  final TextStyle display2;

  /// Large text.
  final TextStyle display1;

  /// Used for large text in dialogs (e.g., the month and year in the dialog
  /// shown by [showDatePicker]).
  final TextStyle headline;

  /// Used for the primary text in app bars and dialogs (e.g., [AppBar.title]
  /// and [AlertDialog.title]).
  final TextStyle title;

  /// Used for the primary text in lists (e.g., [ListTile.title]).
  final TextStyle subhead;

  /// Used for emphasizing text that would otherwise be [body1].
  final TextStyle body2;

  /// Used for the default text style for [Material].
  final TextStyle body1;

  /// Used for auxiliary text associated with images.
  final TextStyle caption;

  /// Used for text on [RaisedButton] and [FlatButton].
  final TextStyle button;

  /// For medium emphasis text that's a little smaller than [subhead].
  final TextStyle subtitle;

  /// The smallest style,
  ///
  /// Typically used for captions or to introduce a (larger) headline.
  final TextStyle overline;

  /// Creates a copy of this text theme but with the given fields replaced with
  /// the new values.
  ///
  /// Consider using [Typography.black] or [Typography.white], which implement
  /// the typography styles in the material design specification, as a starting
  /// point.
  ///
  /// {@tool sample}
  ///
  /// ```dart
  /// /// A Widget that sets the ambient theme's title text color for its
  /// /// descendants, while leaving other ambient theme attributes alone.
  /// class TitleColorThemeCopy extends StatelessWidget {
  ///   TitleColorThemeCopy({Key key, this.child, this.titleColor}) : super(key: key);
  ///
  ///   final Color titleColor;
  ///   final Widget child;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     final ThemeData theme = Theme.of(context);
  ///     return Theme(
  ///       data: theme.copyWith(
  ///         textTheme: theme.textTheme.copyWith(
  ///           title: theme.textTheme.title.copyWith(
  ///             color: titleColor,
  ///           ),
  ///         ),
  ///       ),
  ///       child: child,
  ///     );
  ///   }
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [merge] is used instead of [copyWith] when you want to merge all
  ///    of the fields of a TextTheme instead of individual fields.
  TextTheme copyWith({
    TextStyle display4,
    TextStyle display3,
    TextStyle display2,
    TextStyle display1,
    TextStyle headline,
    TextStyle title,
    TextStyle subhead,
    TextStyle body2,
    TextStyle body1,
    TextStyle caption,
    TextStyle button,
    TextStyle subtitle,
    TextStyle overline,
  }) {
    return TextTheme(
      display4: display4 ?? this.display4,
      display3: display3 ?? this.display3,
      display2: display2 ?? this.display2,
      display1: display1 ?? this.display1,
      headline: headline ?? this.headline,
      title: title ?? this.title,
      subhead: subhead ?? this.subhead,
      body2: body2 ?? this.body2,
      body1: body1 ?? this.body1,
      caption: caption ?? this.caption,
      button: button ?? this.button,
      subtitle: subtitle ?? this.subtitle,
      overline: overline ?? this.overline,
    );
  }

  /// Creates a new [TextTheme] where each text style from this object has been
  /// merged with the matching text style from the `other` object.
  ///
  /// The merging is done by calling [TextStyle.merge] on each respective pair
  /// of text styles from this and the [other] text themes and is subject to
  /// the value of [TextStyle.inherit] flag. For more details, see the
  /// documentation on [TextStyle.merge] and [TextStyle.inherit].
  ///
  /// If this theme, or the `other` theme has members that are null, then the
  /// non-null one (if any) is used. If the `other` theme is itself null, then
  /// this [TextTheme] is returned unchanged. If values in both are set, then
  /// the values are merged using [TextStyle.merge].
  ///
  /// This is particularly useful if one [TextTheme] defines one set of
  /// properties and another defines a different set, e.g. having colors
  /// defined in one text theme and font sizes in another, or when one
  /// [TextTheme] has only some fields defined, and you want to define the rest
  /// by merging it with a default theme.
  ///
  /// {@tool sample}
  ///
  /// ```dart
  /// /// A Widget that sets the ambient theme's title text color for its
  /// /// descendants, while leaving other ambient theme attributes alone.
  /// class TitleColorTheme extends StatelessWidget {
  ///   TitleColorTheme({Key key, this.child, this.titleColor}) : super(key: key);
  ///
  ///   final Color titleColor;
  ///   final Widget child;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     ThemeData theme = Theme.of(context);
  ///     // This partialTheme is incomplete: it only has the title style
  ///     // defined. Just replacing theme.textTheme with partialTheme would
  ///     // set the title, but everything else would be null. This isn't very
  ///     // useful, so merge it with the existing theme to keep all of the
  ///     // preexisting definitions for the other styles.
  ///     TextTheme partialTheme = TextTheme(title: TextStyle(color: titleColor));
  ///     theme = theme.copyWith(textTheme: theme.textTheme.merge(partialTheme));
  ///     return Theme(data: theme, child: child);
  ///   }
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [copyWith] is used instead of [merge] when you wish to override
  ///    individual fields in the [TextTheme] instead of merging all of the
  ///    fields of two [TextTheme]s.
  TextTheme merge(TextTheme other) {
    if (other == null) return this;
    return copyWith(
      display4: display4?.merge(other.display4) ?? other.display4,
      display3: display3?.merge(other.display3) ?? other.display3,
      display2: display2?.merge(other.display2) ?? other.display2,
      display1: display1?.merge(other.display1) ?? other.display1,
      headline: headline?.merge(other.headline) ?? other.headline,
      title: title?.merge(other.title) ?? other.title,
      subhead: subhead?.merge(other.subhead) ?? other.subhead,
      body2: body2?.merge(other.body2) ?? other.body2,
      body1: body1?.merge(other.body1) ?? other.body1,
      caption: caption?.merge(other.caption) ?? other.caption,
      button: button?.merge(other.button) ?? other.button,
      subtitle: subtitle?.merge(other.subtitle) ?? other.subtitle,
      overline: overline?.merge(other.overline) ?? other.overline,
    );
  }

  /// Creates a copy of this text theme but with the given field replaced in
  /// each of the individual text styles.
  ///
  /// The `displayColor` is applied to [display4], [display3], [display2],
  /// [display1], and [caption]. The `bodyColor` is applied to the remaining
  /// text styles.
  ///
  /// Consider using [Typography.black] or [Typography.white], which implement
  /// the typography styles in the material design specification, as a starting
  /// point.
  TextTheme apply({
    String fontFamily,
    double fontSizeFactor = 1.0,
    double fontSizeDelta = 0.0,
    Color displayColor,
    Color bodyColor,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
  }) {
    return TextTheme(
      display4: display4?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      display3: display3?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      display2: display2?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      display1: display1?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headline: headline?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      title: title?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      subhead: subhead?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      body2: body2?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      body1: body1?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      caption: caption?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      button: button?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      subtitle: subtitle?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      overline: overline?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
    );
  }

  /// Linearly interpolate between two text themes.
  ///
  /// {@macro flutter.material.themeData.lerp}
  static TextTheme lerp(TextTheme a, TextTheme b, double t) {
    assert(t != null);
    return TextTheme(
      display4: TextStyle.lerp(a?.display4, b?.display4, t),
      display3: TextStyle.lerp(a?.display3, b?.display3, t),
      display2: TextStyle.lerp(a?.display2, b?.display2, t),
      display1: TextStyle.lerp(a?.display1, b?.display1, t),
      headline: TextStyle.lerp(a?.headline, b?.headline, t),
      title: TextStyle.lerp(a?.title, b?.title, t),
      subhead: TextStyle.lerp(a?.subhead, b?.subhead, t),
      body2: TextStyle.lerp(a?.body2, b?.body2, t),
      body1: TextStyle.lerp(a?.body1, b?.body1, t),
      caption: TextStyle.lerp(a?.caption, b?.caption, t),
      button: TextStyle.lerp(a?.button, b?.button, t),
      subtitle: TextStyle.lerp(a?.subtitle, b?.subtitle, t),
      overline: TextStyle.lerp(a?.overline, b?.overline, t),
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final TextTheme typedOther = other;
    return display4 == typedOther.display4 &&
        display3 == typedOther.display3 &&
        display2 == typedOther.display2 &&
        display1 == typedOther.display1 &&
        headline == typedOther.headline &&
        title == typedOther.title &&
        subhead == typedOther.subhead &&
        body2 == typedOther.body2 &&
        body1 == typedOther.body1 &&
        caption == typedOther.caption &&
        button == typedOther.button &&
        subtitle == typedOther.subtitle &&
        overline == typedOther.overline;
  }

  @override
  int get hashCode {
    // The hashValues() function supports up to 20 arguments.
    return hashValues(
      display4,
      display3,
      display2,
      display1,
      headline,
      title,
      subhead,
      body2,
      body1,
      caption,
      button,
      subtitle,
      overline,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final TextTheme defaultTheme =
        Typography(platform: defaultTargetPlatform).black;
    properties.add(DiagnosticsProperty<TextStyle>('display4', display4,
        defaultValue: defaultTheme.display4));
    properties.add(DiagnosticsProperty<TextStyle>('display3', display3,
        defaultValue: defaultTheme.display3));
    properties.add(DiagnosticsProperty<TextStyle>('display2', display2,
        defaultValue: defaultTheme.display2));
    properties.add(DiagnosticsProperty<TextStyle>('display1', display1,
        defaultValue: defaultTheme.display1));
    properties.add(DiagnosticsProperty<TextStyle>('headline', headline,
        defaultValue: defaultTheme.headline));
    properties.add(DiagnosticsProperty<TextStyle>('title', title,
        defaultValue: defaultTheme.title));
    properties.add(DiagnosticsProperty<TextStyle>('subhead', subhead,
        defaultValue: defaultTheme.subhead));
    properties.add(DiagnosticsProperty<TextStyle>('body2', body2,
        defaultValue: defaultTheme.body2));
    properties.add(DiagnosticsProperty<TextStyle>('body1', body1,
        defaultValue: defaultTheme.body1));
    properties.add(DiagnosticsProperty<TextStyle>('caption', caption,
        defaultValue: defaultTheme.caption));
    properties.add(DiagnosticsProperty<TextStyle>('button', button,
        defaultValue: defaultTheme.button));
    properties.add(DiagnosticsProperty<TextStyle>('subtitle)', subtitle,
        defaultValue: defaultTheme.subtitle));
    properties.add(DiagnosticsProperty<TextStyle>('overline', overline,
        defaultValue: defaultTheme.overline));
  }
}

void main() {}
