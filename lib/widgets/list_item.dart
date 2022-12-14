import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/common/styles.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/layouts/detail_page.dart';

class ListItem extends StatelessWidget {
  final Restaurant restaurant;
  final AppProvider? provider;

  const ListItem({
    Key? key,
    required this.restaurant,
    this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPage(restaurant: restaurant);
        })).then((value) => provider?.getFavoriteRestaurants());
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                    tag: restaurant.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: restaurant.getSmallPicture(),
                        width: 150,
                        height: 140,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, data, _) =>
                            const Center(
                          widthFactor: 0.5,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          restaurant.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 20,
                              color: locationColor,
                            ),
                            Text(restaurant.city),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 25,
                              color: ratingColor,
                            ),
                            Text("${restaurant.rating}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black26,
            height: 1,
            indent: 16,
            endIndent: 16,
          )
        ],
      ),
    );
  }
}
