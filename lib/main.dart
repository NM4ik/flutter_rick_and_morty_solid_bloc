import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/bloc/search_bloc/search_bloc.dart';

import 'package:rick_and_morty_solid_bloc/locator_service.dart' as di;

import 'feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'feature/presentation/pages/person_screen.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
              create: (context) => sl<PersonListCubit>()),
          BlocProvider<SearchBloc>(create: (context) => sl<SearchBloc>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.grey,
          ),
          home: const HomePage(),
        ));
  }
}
