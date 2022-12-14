import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widgets/list_item.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorite';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => AppProvider(apiService: ApiService(), dbService: DbService()).getFavoriteRestaurants(),
        child: Consumer<AppProvider>(
          builder: (context, provider, _) {
            switch (provider.state) {
              case ResultState.loading:
                return const Center(child: CircularProgressIndicator());
              case ResultState.noData:
                return Center(
                  child: Column(
                  children: [
                    Lottie.asset('assets/json/no_favorites.json'),
                    Text(provider.message),
                  ],
                ));
              case ResultState.hasData:
                List<Restaurant> restaurants = provider.favoriteRestaurants;
                return ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListItem(
                      restaurant: restaurants[index],
                      provider: provider,
                    );
                  },
                );
              case ResultState.error:
                return Center(child: Text(provider.message));
            }
          },
        ),
      ),
    );
  }
}
