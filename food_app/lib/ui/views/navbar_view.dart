import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/ui/_widget/custom_navbar.dart';
import 'package:food_app/ui/cubit/navbar_cubit.dart';
import 'package:food_app/ui/views/cart_view.dart';
import 'package:food_app/ui/views/favorite_view.dart';
import 'package:food_app/ui/views/home_view.dart';
import 'package:food_app/ui/views/profile_view.dart';

class NavbarView extends StatefulWidget {
  const NavbarView({super.key});

  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NavbarCubit, int>(builder: (context, state) {
          if (state == 0) {
            return const HomeView();
          }
          if (state == 1) {
            return const FavoriteView();
          }
          if (state == 2) {
            return const CartView();
          }
          if (state == 3) {
            return ProfileView();
          }

          return Container();
        }),
        bottomNavigationBar: const CustomNavBar(),
        extendBody: false,
      ),
    );
  }
}
