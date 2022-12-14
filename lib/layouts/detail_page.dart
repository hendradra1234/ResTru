import 'package:restaurant_app/data/common/styles.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/utils.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/widgets/detail_sliver_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final Restaurant restaurant;
  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider =
        AppProvider(apiService: ApiService(), dbService: DbService());
    return ChangeNotifierProvider(
      create: (_) {
        return provider.getRestaurant(restaurant.id);
      },
      child: Scaffold(
        body: Consumer<AppProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return screen(context, state.restaurant.restaurant, provider);
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Lottie.asset('assets/json/no_internet.json'),
                ),
              );
            }
            return const Center(
              child: Text('No data'),
            );
          },
        ),
      ),
    );
  }

  menuList(List<dynamic> menus, MenuType menuType) {
    return SliverPadding(
      padding: const EdgeInsets.all(4),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 3,
        crossAxisSpacing: 6,
        children: menus.map((e) {
          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: shadowColor, blurRadius: 1)],
            ),
            child: Column(
              children: [
                Expanded(
                  child: (menuType != MenuType.food)
                      ? Image.asset('assets/images/drink.png')
                      : Image.asset('assets/images/food.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Utils.camelCase(e.name),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  Utils.priceGenerator(),
                  style: const TextStyle(
                      color: priceColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  screen(BuildContext context, Restaurant restaurant, AppProvider provider) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
            delegate: DetailSliverAppBar(
                expandedHeight: 250,
                restaurant: restaurant,
                provider: provider)),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(4),
          sliver: SliverToBoxAdapter(
              child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.fastfood_sharp,
                  color: menuColor,
                ),
              ),
              Text(
                'Foods',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )),
        ),
        menuList(restaurant.menus!.foods, MenuType.food),
        SliverPadding(
          padding: const EdgeInsets.all(4),
          sliver: SliverToBoxAdapter(
              child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.local_drink_sharp,
                  color: menuColor,
                ),
              ),
              Text(
                'Drinks',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          )),
        ),
        menuList(restaurant.menus!.drinks, MenuType.drink),
      ],
    );
  }
}
