import 'dart:convert';

import 'package:rick_and_morty_solid_bloc/core/error/exception.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}

const cachedPersonsList = 'CACHED_PERSONS_LIST';

class PersonDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(cachedPersonsList);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((e) => PersonModel.fromJson(json.decode(e)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((e) => json.encode(e.toJson())).toList();

    sharedPreferences.setStringList(cachedPersonsList, jsonPersonsList);
    print('Persons write to Cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
