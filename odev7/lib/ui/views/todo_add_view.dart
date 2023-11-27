import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odev7/ui/cubit/todo_add_cubit.dart';

class TodoAddView extends StatelessWidget {
  TodoAddView({super.key});

  var todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(10, 182, 171, 1);
    const secondaryColor = Color.fromRGBO(21, 21, 21, 1);
    const secondaryColor2 = Color.fromRGBO(32, 31, 31, 1);
    return Scaffold(
      appBar: buildAppbar(primaryColor, context),
      body: buildBody(secondaryColor, primaryColor, secondaryColor2, context),
    );
  }

  AppBar buildAppbar(Color primaryColor, BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: primaryColor,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
      title: const Text(
        "Todo Kayıt",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container buildBody(Color secondaryColor, Color primaryColor,
      Color secondaryColor2, BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: todoText,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Todo",
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: secondaryColor2),
            ),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    context.read<TodoAddCubit>().addTodo(todoText.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ekle")),
            )
          ],
        ),
      ),
    );
  }
}
