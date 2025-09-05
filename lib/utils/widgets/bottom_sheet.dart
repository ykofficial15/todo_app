import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/utils/functions/date_time_converter.dart';

void showTodoViewBottomSheet(
  BuildContext context, {
  required String title,
  required String description,
  required String date,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      side: BorderSide(color: Colors.grey.shade400, width: 1),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.sizeOf(context).height / 2,
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                Text(
                  'Created On: ${DateTime.parse(date).toFormattedSting(showTime: true)}',
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
