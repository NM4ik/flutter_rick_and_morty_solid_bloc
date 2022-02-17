import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty_solid_bloc/core/platform/network_info.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/datasources/person_remote_data_sourse.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/repositories/person_repository.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc & Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => SearchBloc(searchPerson: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(personRepository: sl()));
  sl.registerLazySingleton(() => SearchPersons(sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      remoteDataSourse: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PersonRemoteDataSourse>(
      () => PersonRemoteDataSourceIpml(client: http.Client()));
  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
