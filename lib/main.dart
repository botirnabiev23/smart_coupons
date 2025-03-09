import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_coupons/pages/coupons/bloc/coupon_bloc.dart';
import 'package:smart_coupons/pages/home/bloc/category_bloc.dart';
import 'package:smart_coupons/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoryBloc()
            ..add(
              CategoryLoadEvent(),
            ),
        ),
        BlocProvider(
          create: (_) => CouponBloc()
            ..add(
              LoadCoupons(),
            ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}
