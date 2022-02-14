import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_solid_bloc/core/error/failure.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/entities/person_entity.dart';

//return types: Future<List<Entity>> or Failure;
abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);

  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
