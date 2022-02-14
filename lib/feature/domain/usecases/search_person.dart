import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_solid_bloc/core/error/failure.dart';
import 'package:rick_and_morty_solid_bloc/core/usecases/usecase.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/repositories/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams>{
  final PersonRepository personRepository;

  SearchPerson({required this.personRepository});

  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) async{
    return await personRepository.searchPerson(params.query);
  }
}


class SearchPersonParams extends Equatable {
  String query;

  SearchPersonParams({required this.query});

  @override
  List<Object> get props => [query];
}