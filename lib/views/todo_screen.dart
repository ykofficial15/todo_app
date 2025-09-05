import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/bloc/update_date_cubit.dart';
import 'package:todo_app/utils/themes/color.dart';
import 'package:todo_app/utils/widgets/animated_background.dart';
import 'package:todo_app/views/todo_calender.dart';
import 'package:todo_app/utils/widgets/dialog.dart';
import 'package:todo_app/views/todo_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDateCubit, DateTime>(
      builder: (context, state) {
        return UniversalBackground(
          floatingWidget: FloatingActionButton(
            backgroundColor: AppColor.primary,
            onPressed: () => showAddTodoDialog(context, selectedDate: state),
            child: Icon(Icons.add, color: AppColor.whiteColor),
          ),
          safeArea: true,
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                actions: [
                  Icon(
                    Icons.local_fire_department,
                    size: 35,
                    color: AppColor.whiteColor.withValues(alpha: 0.7),
                  ),
                  SizedBox(width: 12),
                ],
                pinned: true,
                stretch: true,
                centerTitle: false,
                backgroundColor: Colors.transparent,
                title: Text(
                  'Todo App',
                  style: GoogleFonts.poppins(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 40),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.bg,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(color: AppColor.bg),
                  child: Column(children: [TodoCalender(), TodoList()]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
