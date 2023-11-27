import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odev7/data/entity/todo_model.dart';
import 'package:odev7/ui/cubit/todo_home_cubit.dart';
import 'package:odev7/ui/views/todo_add_view.dart';
import 'package:odev7/ui/views/todo_detail_view.dart';

class TodoHomeView extends StatefulWidget {
  const TodoHomeView({super.key});

  @override
  State<TodoHomeView> createState() => _TodoHomeViewState();
}

class _TodoHomeViewState extends State<TodoHomeView> {
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    context.read<TodoHomeCubit>().getTodo();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(10, 182, 171, 1);
    const secondaryColor = Color.fromRGBO(21, 21, 21, 1);
    const secondaryColor2 = Color.fromRGBO(32, 31, 31, 1);
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: buildAppbar(primaryColor, context),
      body: buildBody(secondaryColor2),
      floatingActionButton: actionButton(primaryColor, context, secondaryColor),
    );
  }

  AppBar buildAppbar(Color primaryColor, BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: primaryColor,
      title: isSearch
          ? TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: "Ara", hintStyle: TextStyle(color: Colors.white)),
              onChanged: (searchText) {
                context.read<TodoHomeCubit>().searchTodo(searchText);
              },
            )
          : const Text(
              "Todos",
              style: TextStyle(color: Colors.white),
            ),
      actions: [
        isSearch
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isSearch = false;
                  });
                  context.read<TodoHomeCubit>().getTodo();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ))
            : IconButton(
                onPressed: () {
                  setState(() {
                    isSearch = true;
                  });
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
      ],
    );
  }

  BlocBuilder<TodoHomeCubit, List<TodoModel>> buildBody(Color secondaryColor2) {
    return BlocBuilder<TodoHomeCubit, List<TodoModel>>(
      builder: (context, todoList) {
        if (todoList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, indeks) {
                var todo = todoList[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TodoDetailView(todoModel: todo))).then((value) {
                      context.read<TodoHomeCubit>().getTodo();
                    });
                  },
                  child: Card(
                    color: secondaryColor2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo.name,
                                    maxLines: 5,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${todo.name} silinsin mi?"),
                                    action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: () {
                                        context
                                            .read<TodoHomeCubit>()
                                            .deleteTodo(todo.id);
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center();
        }
      },
    );
  }

  FloatingActionButton actionButton(
      Color primaryColor, BuildContext context, Color secondaryColor) {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      onPressed: () {
        Navigator.push(
                context, MaterialPageRoute(builder: (context) => TodoAddView()))
            .then((value) {
          context.read<TodoHomeCubit>().getTodo();
        });
      },
      child: Icon(
        Icons.add,
        color: secondaryColor,
      ),
    );
  }
}
