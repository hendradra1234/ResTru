import 'package:flutter/material.dart';
import 'package:restaurant_app/layouts/favorites_screen.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/data/common/styles.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final AppProvider provider;

  CustomSliverAppBar({required this.expandedHeight, required this.provider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/restaurants_main.jpg',
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: -15,
          left: 15,
          right: 15,
          child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Row(
                children: [
                  Card(
                    color: searchHeaderColor,
                    elevation: 10,
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 100,
                      child: Form(
                          child: TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            return provider.onSearch(value);
                          }
                          provider.getRestaurants();
                        },
                        decoration: const InputDecoration(
                            hintText: "Search",
                            suffixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10, top: 15)),
                      )),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.favorite),
                        color: favoriteColor,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const FavoritesScreen()));
                        },
                      ),
                    ),
                  )
                ],
              )),
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
}
