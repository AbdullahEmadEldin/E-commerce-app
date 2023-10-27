class FirestoreApiPath {
  static String productsCollection() => 'products/';
  static String userDoc(String uId) => 'users/$uId';
  static String cartProductCollection(String uId, String userProductId) =>
      'users/$uId/cart/$userProductId';
  static String favouriteCollection(String uId, String userProductId) =>
      'users/$uId/favourites/$userProductId';
  static String cartCollection(String uId) => 'users/$uId/cart/';
  static String delivryOptions() => 'delivryOptions/';
  static String userAddresses(String uId) => 'users/$uId/userAdresses';
  static String specificAddress(String uId, String addressId) =>
      'users/$uId/userAdresses/$addressId';
}
