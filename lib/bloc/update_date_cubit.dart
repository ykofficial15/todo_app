import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateDateCubit extends Cubit<DateTime> {
  UpdateDateCubit() : super(DateTime.now());

  void update(DateTime date) {
    emit(date);
  }
}
