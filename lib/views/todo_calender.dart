import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/bloc/todo_bloc/todo_cubit.dart';
import 'package:todo_app/bloc/update_date_cubit.dart';
import 'package:todo_app/utils/themes/color.dart';

class TodoCalender extends StatelessWidget {
  const TodoCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDateCubit, DateTime>(
      builder: (context, state) {
        return SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 14,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected =
                  date.year == state.year &&
                  date.month == state.month &&
                  date.day == state.day;
              return Container(
                width: 60,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primary : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: AppColor.whiteColor.withValues(alpha: 0.3),
                    onTap: () {
                      context.read<UpdateDateCubit>().update(date);
                      context.read<TodoCubit>().fetchTodosByDate(date);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${date.day}",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color:
                                  isSelected
                                      ? AppColor.whiteColor
                                      : Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          [
                            "Sun",
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                            "Sat",
                          ][date.weekday % 7],
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color:
                                  isSelected
                                      ? AppColor.whiteColor
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
