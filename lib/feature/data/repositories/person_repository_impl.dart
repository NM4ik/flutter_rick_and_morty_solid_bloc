import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_solid_bloc/core/error/exception.dart';
import 'package:rick_and_morty_solid_bloc/core/error/failure.dart';
import 'package:rick_and_morty_solid_bloc/core/platform/network_info.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/datasources/person_remote_data_sourse.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/models/person_model.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSourse remoteDataSourse;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSourse,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remoteDataSourse.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSourse.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
