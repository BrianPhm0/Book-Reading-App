class ApiConfig {
  static const String baseUrl = 'http://localhost:7274/api';

  //register
  static const String registerEndpoint = '$baseUrl/Auth/register';

  //Login
  static const String loginEndpoint = '$baseUrl/Auth/login';

  //get User

  static const String getUser = '$baseUrl/User/user';
  //get category

  static const String getCategory = '$baseUrl/Brand';

  //get book by category
  static const String getBookByCategory = '$baseUrl/Book/brand?id=';

  //get latest book
  static const String getLatestBook =
      '$baseUrl/Book/latest-books?latestCount=5';

  //get best order
  static const String getBestDeal = '$baseUrl/Book/best-seller?bestCount=5';

  //get top book
  static const String getTopBook = '$baseUrl/Book/top-books?topCount=5';

  //post card item
  static const String postCartItem = '$baseUrl/CartItem?';

  //get card item
  static const String getCartItem = '$baseUrl/CartItem';

  //delete cart
  static const String deleteCart = '$baseUrl/CartItem/delete?productId=';

  //check out with cash
  static const String payCash = '$baseUrl/Orders/checkout';
}
