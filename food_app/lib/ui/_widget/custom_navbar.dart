import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/ui/cubit/navbar_cubit.dart';

class CustomNavBar extends StatefulWidget {
  final void Function()? onPressed;
  const CustomNavBar({super.key, this.onPressed});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  static const selectColor = ConstColor.primary;
  static const unSelectColor = ConstColor.grey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      child: Container(
        height: MediaQuery.of(context).size.height * .09,
        decoration: BoxDecoration(
            color: ConstColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 3,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navbarItem(Icons.home, 0),
            navbarItem(Icons.favorite, 1),
            navbarItem(Icons.shopping_cart, 2),
            navbarItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget navbarItem(IconData? icon, int index) {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, state) {
        var currentIndex = context.watch<NavbarCubit>().state;
        return IconButton(
          onPressed: () => context.read<NavbarCubit>().updateNavigation(index),
          icon: Icon(
            icon,
            size: 30,
            color: currentIndex == index ? selectColor : unSelectColor,
          ),
        );
      },
    );
  }
}
