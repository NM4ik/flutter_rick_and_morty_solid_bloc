import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_solid_bloc/core/error/failure.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/usecases/search_person.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  SearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<PersonSearchEvent>((event, emit) async {
      if (event is SearchPersons) {
        emit(PersonSearchLoading());

        final failuerOrPerson = await searchPerson
            .call(SearchPersonParams(query: event.personQuery));

        emit(failuerOrPerson.fold(
            (failure) => PersonSearchError(message: _failureToMessage(failure)),
            (person) => PersonSearchLoaded(persons: person)));
      }
    });
  }

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected error';
    }
  }
}
