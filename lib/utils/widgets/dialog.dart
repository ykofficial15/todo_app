import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_app/utils/themes/color.dart';

void showAddTodoDialog(
  BuildContext context, {
  Map<String, dynamic>? todo,
  required DateTime selectedDate,
}) {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController(text: todo?['title'] ?? '');
  final descController = TextEditingController(
    text: todo?['description'] ?? '',
  );

  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            todo == null ? "Add Todo" : "Edit Todo",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "Title"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 5,
                  controller: descController,
                  decoration: const InputDecoration(hintText: "Description"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description cannot be empty";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final title = titleController.text.trim();
                  final desc = descController.text.trim();
                  final cubit = context.read<TodoCubit>();
                  if (todo == null) {
                    cubit.repo.insertTodo(title, desc, selectedDate);
                  } else {
                    cubit.updateTodo(
                      todo['id'],
                      title,
                      desc,
                      todo['isCompleted'],
                    );
                  }
                  cubit.fetchTodosByDate(selectedDate);
                  Navigator.pop(context);
                }
              },
              child: Text(
                todo == null ? "Add" : "Update",
                style: GoogleFonts.poppins(color: AppColor.whiteColor),
              ),
            ),
          ],
        ),
  );
}
