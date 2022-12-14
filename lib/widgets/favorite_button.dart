import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurant restaurant;
  final AppProvider provider;

  const FavoriteButton(
      {Key? key, required this.restaurant, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider(apiService: ApiService(), dbService: DbService()).getFavoriteRestaurants(),
      child: Consumer<AppProvider>(builder: (context, provider, _) {
        switch (provider.state) {
          case ResultState.loading:
            return const Icon(Icons.favorite_outline);
          case ResultState.noData:
            return IconButton(
              icon: const Icon(Icons.favorite_outline, color: Colors.black87),
              onPressed: () {
                provider.toggleFavorite(restaurant).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Saved to favorite")));
                });
              },
            );
          case ResultState.hasData:
            return provider.favoriteRestaurants
                    .where((element) => element.id == restaurant.id)
                    .isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                    onPressed: () {
                      provider.toggleFavorite(restaurant).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Removed from favorite")));
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.favorite_outline, color: Colors.black87),
                    onPressed: () {
                      provider.toggleFavorite(restaurant).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Saved to favorite")));
                      });
                    },
                  );
          case ResultState.error:
            return const Icon(Icons.favorite_outline, color: Colors.black87);
        }
      }),
    );
  }
}
