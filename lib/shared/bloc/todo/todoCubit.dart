import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/bloc/todo/todostates.dart';

class TODOAppCubit extends Cubit<TODOStateBase>{
  TODOAppCubit() : super(TODOInitState());
  static TODOAppCubit getCubitOfTodo(BuildContext context)=> BlocProvider.of(context);
}