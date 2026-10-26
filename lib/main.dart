import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'navigation/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NusantaraCerdasApp());
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(
          create: (context) => FavoritCubit(),
        ),
        BlocProvider<PengajuanCubit>(
          create: (context) => PengajuanCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Nusantara Cerdas Mobile',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRoutes.beranda,
            routes: AppRoutes.daftarRoute(),
            onGenerateRoute: AppRoutes.bentukRoute,
            onUnknownRoute: AppRoutes.routeTidakDikenal,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}