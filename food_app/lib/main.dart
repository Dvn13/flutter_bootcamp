import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/services/firebase_service.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';
import 'package:food_app/ui/cubit/home_cubit.dart';
import 'package:food_app/ui/cubit/detail_page_cubit.dart';
import 'package:food_app/ui/cubit/navbar_cubit.dart';
import 'package:food_app/ui/cubit/orders_cubit.dart';
import 'package:food_app/ui/cubit/sign_in_cubit.dart';
import 'package:food_app/ui/cubit/sign_up_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/ui/views/navbar_view.dart';
import 'package:food_app/ui/views/onboard_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = FirebaseService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => SignInCubit()),
        BlocProvider(create: (context) => DetailFoodCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => FoodCrudCubit()),
        BlocProvider(create: (context) => NavbarCubit()),
        BlocProvider(create: (context) => OrdersCubit()),
      ],
      child: MaterialApp(
        title: 'Food App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ConstColor.primary),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            if (firebaseService.getUserUid() != null) {
              return const NavbarView();
            } else {
              return const OnboardView();
            }
          });
        },
      ),
    );
  }
}
