import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/ui/cubit/navbar_cubit.dart';
import 'package:food_app/ui/views/onboard_view.dart';
import 'package:food_app/ui/views/orders_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  var textStyle =
      const TextStyle(color: ConstColor.white, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    var firebaseService = FirebaseService();
    User user = firebaseService.auth.currentUser!;
    return Column(
      children: [
        users(user),
        listView(context, firebaseService),
      ],
    );
  }

  Widget users(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: ConstColor.primary,
        child: listTile(
            leading: const Icon(
              Icons.email,
              color: ConstColor.white,
            ),
            title: Text(
              user.email.toString(),
              style: textStyle,
            )),
      ),
    );
  }

  Widget listView(BuildContext context, FirebaseService firebaseService) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: ConstColor.primary,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ordersTile(context),
            const Divider(
              height: 2,
              color: ConstColor.white,
            ),
            signOut(firebaseService, context)
          ],
        ),
      ),
    );
  }

  Widget signOut(FirebaseService firebaseService, BuildContext context) {
    return listTile(
      leading: const Icon(
        Icons.logout_outlined,
        color: ConstColor.white,
      ),
      title: Text(
        'Çıkış',
        style: textStyle,
      ),
      onTap: () async {
        await firebaseService.signOut();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const OnboardView()),
            (Route<dynamic> route) => false);
        context.read<NavbarCubit>().updateNavigation(0);
      },
    );
  }

  Widget ordersTile(BuildContext context) {
    return listTile(
      leading: const Icon(
        Icons.shopping_cart,
        color: ConstColor.white,
      ),
      title: Text(
        'Geçmiş Siparişlerim',
        style: textStyle,
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OrdersView()));
      },
    );
  }

  Widget listTile(
      {required Widget leading,
      required Widget title,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        title: title,
      ),
    );
  }
}
