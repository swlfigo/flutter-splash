import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:splash/component/utils/colors_ext.dart';
import 'package:splash/module/search_module/Model/colleciton.dart';

class UserCollectionWidget extends StatelessWidget {
  const UserCollectionWidget({
    super.key,
    required this.collectionInfo,
  });

  final UnsplashCollectionInfo collectionInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: HexColor("1c1c1c"),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1),
                itemCount: collectionInfo.previewPhotos == null
                    ? 0
                    : collectionInfo.previewPhotos!.length > 3
                        ? 3
                        : collectionInfo.previewPhotos!.length,
                itemBuilder: (BuildContext context, int index) {
                  final imageURL =
                      collectionInfo.previewPhotos?[index].urls?.thumb;
                  if (imageURL == null) {
                    return Container();
                  }
                  return CachedNetworkImage(
                    imageUrl: imageURL,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 8, bottom: 10),
                child: Text(
                  collectionInfo.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    '${collectionInfo.totalPhotos} photos · Curated by ${collectionInfo.user.name}'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
