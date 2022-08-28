import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

// StateNotifier のステート（状態）はイミュータブル（不変）である必要があります。
// ここは Freezed のようなパッケージを利用してイミュータブルにする。
@freezed
abstract class Todo with _$Todo {
  const factory Todo({required String id, required String description, required bool completed}) = _Todo;
}