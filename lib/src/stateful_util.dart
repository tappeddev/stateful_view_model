

/// Every state needs to implements this abstract class.
/// We need to clone every state to avoid weird behavior with pointer / references
abstract class Cloneable<T> {
  T copy();
}

/// You get this function if you call the method: setState
///
/// Example:
///
///     setState((state){
///       state.number = 6;
///       return state;
///     });
///
/// Be careful! You need to return the new state
typedef T Reducer<T>(T state);