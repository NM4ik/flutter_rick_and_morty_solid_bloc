import 'package:flutter/material.dart';
import 'package:rick_and_morty_solid_bloc/common/app_colors.dart';
import 'package:rick_and_morty_solid_bloc/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty_solid_bloc/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity personEntity;

  const PersonCard({Key? key, required this.personEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PersonDetailPage(personEntity: personEntity)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              child: PersonCacheImage(
                width: 166,
                height: 166,
                imageUrl: personEntity.image,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(personEntity.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: personEntity.status == 'Alive'
                                ? Colors.green
                                : Colors.red),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                          child: Text(
                        '${personEntity.status}  -  ${personEntity.species}',
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text('Last known location: ',
                      style: TextStyle(color: AppColors.greyColor)),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    personEntity.location.name,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Origin: ',
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    personEntity.origin.name,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
