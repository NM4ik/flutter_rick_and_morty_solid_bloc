import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters..');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Inside custom search delegate and search query is: $query');
    BlocProvider.of<SearchBloc>(context, listen: false).add(SearchPersons(query));
    // context.watch<SearchBloc>()..add(SearchPersons(query));
    return BlocBuilder<SearchBloc, PersonSearchState>(
        builder: (context, state) {
      if (state is PersonSearchLoading) {
        return const CircularProgressIndicator();
      } else if (state is PersonSearchLoaded) {
        final person = state.persons;
        if (person.isEmpty) {
          return _showErrorText('No characters with that name found');
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            PersonEntity result = person[index];
            return SearchResult(personResult: result);
          },
          itemCount: person.isNotEmpty ? person.length : 0,
        );
      } else if (state is PersonSearchError) {
        return _showErrorText(state.message);
      } else {
        return const Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Text(
                _suggestions[index],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: _suggestions.length),
      );
    }
  }

  Widget _showErrorText(String message) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
