class ApiConfig {
  // static const String baseUrl = 'http://10.0.2.2:7274/api';
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

  //get purchase ebook

  static const String purchaseEbook =
      '$baseUrl/Book/purchased-book?page=1&size=10';

  //get detail book

  static const String detailBook = '$baseUrl/Book/';
  //get review ebook
  static const String review = '$baseUrl/Review/';

  //get voucher
  static const String voucher = '$baseUrl/Voucher/user';

  //update item
  static const String updateItem = '$baseUrl/CartItem/update?productId=';

  //get public voucher
  static const String getPublicVoucher = '$baseUrl/Voucher/of-mobile';

  //add voucher
  static const String addVoucher = '$baseUrl/VoucherUser/code';

  //get order
  static const String getOrder = '$baseUrl/Orders/user?page=1&size=10';

  //get order by id
  static const String getOrderById = '$baseUrl/Orders/';

  //get order by id
  static const String cancelOrder = '$baseUrl/Orders/cancel-status?id=';

//get order by id
  static const String postReview = '$baseUrl/Review';

  //search book
  static const String searchBook = '$baseUrl/Book/search?';

  //update user
  static const String updateUser = '$baseUrl/User?id=';
}
