import 'package:flutter/material.dart';
import 'package:restaurant_app/data/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/db_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'review_dialog.dart';

class ReviewScreen extends StatelessWidget {
  static const routeName = '/feedback';
  final Restaurant restaurant;

  const ReviewScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider providers = AppProvider(apiService: ApiService(), dbService: DbService());

    return Scaffold(
      // backgroundColor: baseColor,
      appBar: AppBar(
        // backgroundColor: primaryColor,
        title: const Text("Feedback"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => providers.getRestaurant(restaurant.id),
        child: Consumer<AppProvider>(builder: (context, provider, _) {
          providers = provider;
          switch (provider.state) {
            case ResultState.loading:
              return const Center(child: CircularProgressIndicator());
            case ResultState.noData:
              return Center(child: Text(provider.message));
            case ResultState.hasData:
              Restaurant restaurants = provider.restaurant.restaurant;
              return ListView.builder(
                  itemCount: restaurants.customerReviews!.length,
                  itemBuilder: (context, index) {
                    Review review = restaurants.customerReviews![index];
                    return item(review);
                  });
            case ResultState.error:
              return Center(
                child: Lottie.asset('assets/json/no_internet.json'),
                // child: Text(providers.message),
              );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                ReviewDialog(provider: providers, id: restaurant.id),
          );
        },
        child: const Icon(Icons.add_comment),
      ),
    );
  }

  Widget item(Review review) {
    return Card(
        color: listColor,
        margin: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Text(
                  review.name![0],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        review.date!,
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Text(
                        review.review!,
                        maxLines: 5,
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
