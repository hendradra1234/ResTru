import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:restaurant_app/widgets/custom_sliver_appbar.dart';
import 'package:restaurant_app/widgets/list_item.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:lottie/lottie.dart';

class ListPage extends StatelessWidget {
  static const routeName = '/list';

  const ListPage({Key? key}) : super(key: key);

  Widget _lists(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => AppProvider(apiService: ApiService(), dbService: DbService()).getRestaurants(),
          child: CustomScrollView(
            slivers: [
              Consumer<AppProvider>(
                builder: (context, provider, _) {
                  return SliverPersistentHeader(
                    delegate: CustomSliverAppBar(
                        expandedHeight: 150, provider: provider),
                  );
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              Consumer<AppProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state.state == ResultState.hasData) {
                    return SliverList(
                        delegate: SliverChildListDelegate(state
                            .result.restaurants
                            .map((restaurant) => _card(context, restaurant))
                            .toList()));
                  } else if (state.state == ResultState.error) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Lottie.asset('assets/json/no_internet.json'),
                      ),
                    );
                  }
                  return SliverFillRemaining(
                    child: Center(
                        child: Lottie.asset('assets/json/search_empty.json')),
                  );
                },
              )
            ],
          ),
        ));
  }

  Widget _card(BuildContext context, Restaurant restaurant) {
    return ListItem(
      restaurant: restaurant
    );
  }

  Widget _android(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: _lists(context),
    );
  }

  Widget _ios(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: baseColor,
      child: _lists(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _android,
      iosBuilder: _ios,
    );
  }
}
