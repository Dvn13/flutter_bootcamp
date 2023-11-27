import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odev7/ui/cubit/todo_add_cubit.dart';
import 'package:odev7/ui/cubit/todo_detail_cubit.dart';
import 'package:odev7/ui/cubit/todo_home_cubit.dart';
import 'package:odev7/ui/views/todo_home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => TodoAddCubit()),
      BlocProvider(create: (context) => TodoDetaiCubit()),
      BlocProvider(create: (context) => TodoHomeCubit()),
    ], child: materialApp());
  }

  MaterialApp materialApp() {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromRGBO(10, 182, 171, 1)),
        useMaterial3: true,
      ),
      home: const TodoHomeView(),
    );
  }
}
