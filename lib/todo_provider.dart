import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'todo.dart';

// StateNotifierProvider に渡すことになる StateNotifier クラス。
// このクラスではステートを `state` プロパティの外に公開しない。
// つまり、ステートに関しては public なゲッターやプロパティは作らない。
// public メソッドを通じて UI 側にステートの操作を許可する。
class TodosNotifier extends StateNotifier<List<Todo>> {
  // Todo リストを空のリストとして初期化します。
  TodosNotifier(): super([]);

  // Todo の追加
  void addTodo(Todo todo) {
    // ステート自体もイミュータブルなため、`state.add(todo)`
    // のような操作はできない。
    // 代わりに、既存 Todo と新規 Todo を含む新しいリストを作成する。
    // Dart のスプレッド演算子を使うと便利!
    state = [...state, todo];
    // `notifyListeners` などのメソッドを呼ぶ必要はない。
    // `state =` により必要なときに UI側 に通知が届き、ウィジェットが更新される。
  }

  // Todo の削除
  void removeTodo(String todoId) {
    // しつこいが、ステートはイミュータブル。 
    // そのため既存リストを変更するのではなく、新しくリストを作成する必要がある。
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Todo の完了ステータスの変更
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        // ID がマッチした Todo のみ、完了ステータスを変更する。
        if (todo.id == todoId)
          // ステートはイミュータブルなので
          // Todo クラスに実装した `copyWith` メソッドを使用して
          // Todo オブジェクトのコピーを作る必要がある。
          todo.copyWith(completed: !todo.completed)
        else
          // ID が一致しない Todo は変更しない。
          todo,
    ];
  }
}

// 最後に TodosNotifier のインスタンスを値に持つ StateNotifierProvider を作成し、
// UI 側から Todo リストを操作することを可能にする。
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});