import 'package:mobx/mobx.dart';
part 'list.store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  @observable
  String newTodoTitle = "";
  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;

  ObservableList<String> todolist = ObservableList();

  @action
  void addTodo() {
    todolist.add(newTodoTitle);
  }
}
