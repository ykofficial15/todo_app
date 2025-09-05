import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_app/bloc/todo_bloc/todo_repo.dart';
import 'package:todo_app/bloc/update_date_cubit.dart';
import 'package:todo_app/utils/themes/theme.dart';
import 'package:todo_app/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  TodoCubit(TodoRepo())..fetchTodosByDate(DateTime.now()),
        ),
        BlocProvider(create: (context) => UpdateDateCubit()),
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
