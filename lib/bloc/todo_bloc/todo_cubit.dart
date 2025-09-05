import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todo_repo.dart';
import 'package:todo_app/bloc/todo_bloc/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepo repo;
  TodoCubit(this.repo) : super(TodoInitial());

  Future<void> fetchTodosByDate(DateTime date) async {
    try {
      emit(TodoLoading());
      final todos = await repo.getTodosByDate(date);
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> addTodo(String title, String description, DateTime date) async {
    try {
      await repo.insertTodo(title, description, date);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> updateTodo(
    int id,
    String title,
    String description,
    int isCompleted,
  ) async {
    try {
      await repo.updateTodo(id, title, description, isCompleted);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await repo.deleteTodo(id);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }
}
