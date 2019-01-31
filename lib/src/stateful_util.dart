

/// Every state needs to implements this "Interface"
abstract class Cloneable<T> {
  T copy();
}

///
typedef T Reducer<T>(T state);