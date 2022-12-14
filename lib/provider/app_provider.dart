part of 'provider.dart';

class AppProvider extends ChangeNotifier {
  final ApiService apiService;
  final DbService dbService;

  late ResponseRestaurant _responseRestaurant;
  late ResponseRestaurantDetail _responseRestaurantDetail;
  late List<Restaurant> _favoriteRestaurant;
  late ResultState _state;
  late String _message;
  late String _query = "";

  ResponseRestaurant get result => _responseRestaurant;
  ResponseRestaurantDetail get restaurant => _responseRestaurantDetail;
  List<Restaurant> get favoriteRestaurants => _favoriteRestaurant;
  ResultState get state => _state;
  String get message => _message;

  AppProvider getRestaurants() {
    _fetchAllRestaurants();
    return this;
  }

  AppProvider getRestaurant(String id) {
    _fetchRestaurant(id);
    return this;
  }

  AppProvider({required this.apiService, required this.dbService});

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.search(query: _query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      }
      _state = ResultState.hasData;
      notifyListeners();
      return _responseRestaurant = response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      }
      _state = ResultState.hasData;
      notifyListeners();
      return _responseRestaurant = response;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetail(id);
      if (!response.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _responseRestaurantDetail = response;
      }
      _state = ResultState.noData;
      notifyListeners();
      return _message = "No data found";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void onSearch(String query) {
    _query = query;
    if (query == "" || query == " ") _fetchAllRestaurants();

    _fetchRestaurants();
  }

  Future<dynamic> postReview(Review review) async {
    try {
      final response = await apiService.postReview(review);

      if (!response.error) _fetchRestaurant(review.id!);
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

   AppProvider getFavoriteRestaurants() {
    _getFavorites();
    return this;
  }

  Future<dynamic> _getFavorites() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await dbService.getFavorites();
      if (response.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _favoriteRestaurant = response;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No Favorite Restaurants";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> toggleFavorite(Restaurant restaurant) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await dbService.toggleFavorite(restaurant);
      if (response.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _favoriteRestaurant = response;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No data found";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
