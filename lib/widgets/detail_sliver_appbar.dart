import 'package:flutter/material.dart';
import 'package:restaurant_app/data/common/styles.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/layouts/reviews_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant_app/widgets/favorite_button.dart';

class DetailSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Restaurant restaurant;
  final AppProvider provider;

  DetailSliverAppBar(
      {required this.expandedHeight,
      required this.restaurant,
      required this.provider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Hero(
          tag: restaurant.id,
          child: CachedNetworkImage(
            imageUrl: restaurant.getMediumPicture(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          child: SafeArea(
              child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: backColor,
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          )),
        ),
        Positioned(
          top: 150 - shrinkOffset,
          left: 8,
          right: 8,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2, spreadRadius: 0.1, color: shadowColor)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        IconButton(
                            padding: const EdgeInsets.all(1),
                            icon: const Icon(Icons.info_outline),
                            onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      restaurant.name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    content: Text(
                                      restaurant.description,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, "BACK");
                                          },
                                          child: const Text('BACK'))
                                    ],
                                  ),
                                )),
                        FavoriteButton(
                            restaurant: restaurant, provider: provider)
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: locationColor,
                        ),
                        Expanded(
                            child: Text(
                                "${restaurant.city}, ${restaurant.address}",
                                style: Theme.of(context).textTheme.bodyText1)),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 20,
                          color: ratingColor,
                        ),
                        Text("${restaurant.rating}",
                            style: const TextStyle(
                              color: Colors.black,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.rate_review,
                          size: 20,
                          color: reviewColor,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ReviewScreen(restaurant: restaurant);
                            })).then((value) => setState(provider));
                          },
                          child: Text(
                            " ${restaurant.customerReviews!.length} Feedback",
                            style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: restaurant.categories!
                            .map(
                              (cat) => Transform(
                                transform: Matrix4.identity()..scale(0.8),
                                child: Chip(
                                  label: Text(cat.name),
                                  backgroundColor: baseColor,
                                  shape: const StadiumBorder(
                                      side: BorderSide(color: categoryColor)),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Text(
                      restaurant.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  setState(AppProvider provider) {
    provider.getRestaurant(restaurant.id);
  }
}
