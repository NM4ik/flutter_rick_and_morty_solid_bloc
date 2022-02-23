import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_solid_bloc/common/app_colors.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/bloc/search_bloc/search_bloc.dart';

import 'package:rick_and_morty_solid_bloc/locator_service.dart' as di;

import 'feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'feature/presentation/pages/person_screen.dart';
import 'locator_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
              create: (context) => sl<PersonListCubit>()..loadPerson()),
          BlocProvider<SearchBloc>(create: (context) => sl<SearchBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
