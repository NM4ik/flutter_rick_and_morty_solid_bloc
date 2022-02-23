import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_solid_bloc/core/error/exception.dart';
import 'package:rick_and_morty_solid_bloc/feature/data/models/person_model.dart';

abstract class PersonRemoteDataSourse {
  Future<List<PersonModel>> getAllPersons(int page);

  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceIpml implements PersonRemoteDataSourse {
  final http.Client client;

  PersonRemoteDataSourceIpml({required this.client});


  // https://rickandmortyapi.com/api/character/?page=1 as 1st endpoint
  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?page=$page');

  // https://rickandmortyapi.com/api/character/?name=rick as 2nd endpoint
  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List<dynamic>)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
