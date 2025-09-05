import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_app/bloc/todo_bloc/todo_repo.dart';
import 'package:todo_app/views/todo_screen.dart';

void main() {
  testWidgets('Add and Delete todo from UI', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => TodoCubit(TodoRepo()),
          child: const TodoScreen(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('titleField')), 'Test Todo');
    await tester.enterText(find.byKey(const Key('descField')), 'Test Desc');

    await tester.tap(find.byKey(const Key('saveButton')));
    await tester.pumpAndSettle();

    expect(find.text('Test Todo'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    expect(find.text('Test Todo'), findsNothing);
  });
}
