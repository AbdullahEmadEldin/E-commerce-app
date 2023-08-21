class ApiPath {
  static String productsCollection() => 'products/';
  static String userDoc(String uId) => 'users/$uId';
  static String cartProductCollection(String uId, String userProductId) =>
      'users/$uId/cart/$userProductId';
  static String cartCollection(String uId) => 'users/$uId/cart/';
  static String delivryOptions() => 'delivryOptions/';
}
