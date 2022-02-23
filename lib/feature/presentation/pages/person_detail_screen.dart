import 'package:flutter/material.dart';
import 'package:rick_and_morty_solid_bloc/common/app_colors.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity personEntity;

  const PersonDetailPage({Key? key, required this.personEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            personEntity.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          PersonCacheImage(
            width: 260,
            height: 260,
            imageUrl: personEntity.image,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: personEntity.status == 'Alive'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                personEntity.status,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: FastText(titleInfo: 'Gender: ', info: personEntity.gender),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: FastText(titleInfo: 'Number of episodes: ', info: personEntity.episode.length.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: FastText(titleInfo: 'Species: ', info: personEntity.species),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: FastText(titleInfo: 'Last known location: ', info: personEntity.location.name),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: FastText(titleInfo: 'Origin: ', info: personEntity.origin.name),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: FastText(titleInfo: 'Was created: ', info: personEntity.created.toString()),
          ),
        ],
      ),
    );
  }
}

class FastText extends StatelessWidget {
  final String titleInfo;
  final String info;

  const FastText({Key? key, required this.titleInfo, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          titleInfo,
          style: const TextStyle(
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          info,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
