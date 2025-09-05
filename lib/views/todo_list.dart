import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:todo_app/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_app/bloc/todo_bloc/todo_state.dart';
import 'package:todo_app/bloc/update_date_cubit.dart';
import 'package:todo_app/utils/themes/color.dart';
import 'package:todo_app/utils/widgets/bottom_sheet.dart';
import 'package:todo_app/utils/widgets/dialog.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            ),
          );
        } else if (state is TodoLoaded) {
          if (state.todos.isEmpty) {
            return Expanded(
              child: Center(child: Text("No todos for this date")),
            );
          }
          return BlocBuilder<UpdateDateCubit, DateTime>(
            builder: (context, updateState) {
              return ListView.separated(
                padding: EdgeInsets.all(12),
                separatorBuilder: (context, index) => SizedBox(height: 6),
                shrinkWrap: true,
                itemCount: state.todos.length,
                itemBuilder: (_, index) {
                  final todo = state.todos[index];
                  final isCompleted = todo['isCompleted'] == 1;

                  return Dismissible(
                    behavior: HitTestBehavior.opaque,
                    key: Key(todo['id'].toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: AppColor.whiteColor),
                    ),
                    onDismissed: (_) {
                      context.read<TodoCubit>().deleteTodo(todo['id']);
                      context.read<TodoCubit>().fetchTodosByDate(updateState);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${todo['title']} deleted")),
                      );
                    },
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.whiteColor,
                      child: ListTile(
                        onTap: () {
                          showTodoViewBottomSheet(
                            context,
                            title: todo['title'],
                            description: todo['description'],
                            date: todo['createdAt'],
                          );
                        },
                        title: Text(
                          maxLines: 1,
                          todo['title'],
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              decoration:
                                  isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          todo['description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        leading: Checkbox(
                          side: BorderSide(color: Colors.black, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          value: isCompleted,
                          activeColor: AppColor.primary,
                          focusColor: AppColor.primary,
                          onChanged: (val) {
                            context.read<TodoCubit>().updateTodo(
                              todo['id'],
                              todo['title'],
                              todo['description'],
                              val == true ? 1 : 0,
                            );
                            context.read<TodoCubit>().fetchTodosByDate(
                              updateState,
                            );
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed:
                              () => showAddTodoDialog(
                                context,
                                todo: todo,
                                selectedDate: updateState,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is TodoFailure) {
          return Center(child: Text("Error: ${state.error}"));
        }
        return const Center(child: Text("Loading..."));
      },
    );
  }
}
