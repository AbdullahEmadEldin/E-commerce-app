import 'package:e_commerce_app/data_layer/Models/order.dart';
import 'package:e_commerce_app/data_layer/Models/product.dart';
import 'package:e_commerce_app/data_layer/Models/user_product.dart';
import 'package:e_commerce_app/data_layer/Services/firestore_services.dart';
import 'package:e_commerce_app/Utilities/api_paths.dart';

import '../Models/address_model.dart';
import '../Models/delivery_option.dart';
import '../Models/user.dart';

abstract class Repository {
  Stream<List<Product>> salesProductStream();
  Stream<List<Product>> newProductStream();
  Stream<List<Product>> favouriteProducts();
  Stream<List<Product>> getWomenProducts();
  Stream<List<Product>> getMenProducts();
  Stream<List<UserProduct>> myCart();
  Stream<List<Order>> myOrders();
  Stream<List<DeliveryOption>> deliveryOptions();
  Stream<List<ShippingAddress>> getShippingAddresses();
  Stream<List<ShippingAddress>> getDefaultShippingAddress();
  Future<UserData> getUserData();
  Future<void> setUserData(UserData userData);
  Future<void> addToCart(UserProduct userProduct);
  Future<void> createOrder(Order order);
  Future<void> addProduct(Product product);
  Future<void> saveAddress(ShippingAddress usersAddress);
  Future<void> deleteCartProduct({required UserProduct userProduct});
  Future<void> clearCartAfterOrder();
  Future<void> deleteProducts(Product product);
  Future<void> deleteAddress(ShippingAddress address);
}

///this calss' methods will control and call methods from firestore srvices
/////////***************The one and the only one *******************/////////
class FirestoreRepo implements Repository {
  final String uId;
  FirestoreRepo(this.uId);

  final _service = FirestoreServices.instance;

  ///Data streams (getters) *****************************
  //QueryProcess methods

  ///Products getter================
  @override
  Stream<List<Product>> salesProductStream() {
    return _service.collectionsStream(
      collectionPath: FirestoreApiPath.productsCollection(),
      deMapping: (mapData, docId) => Product.formMap(mapData!, docId),
      queryPeocess: (query) => query.where('discount', isNotEqualTo: 0),
    );
  }

  @override
  Stream<List<Product>> newProductStream() {
    return _service.collectionsStream(
        collectionPath: 'products/',
        deMapping: (mapData, docId) => Product.formMap(mapData!, docId),
        queryPeocess: (query) => query.where('discount', isEqualTo: 0));
  }

  @override
  Stream<List<Product>> favouriteProducts() {
    return _service.collectionsStream(
        collectionPath: 'users/$uId/favourites/',
        deMapping: (mapData, docId) => Product.formMap(mapData!, docId),
        queryPeocess: (query) => query.where('isFavourite', isEqualTo: true));
  }

  @override
  Stream<List<UserProduct>> myCart() => _service.collectionsStream(
      collectionPath: FirestoreApiPath.cartCollection(uId),
      deMapping: ((data, documentId) =>
          UserProduct.fromMap(data!, documentId)));
  @override
  Stream<List<Order>> myOrders() => _service.collectionsStream(
      collectionPath: FirestoreApiPath.orderCollection(uId),
      deMapping: ((data, documentId) => Order.fromMap(data!, documentId)));

  @override
  Stream<List<Product>> getWomenProducts() {
    return _service.collectionsStream(
        collectionPath: FirestoreApiPath.productsCollection(),
        deMapping: (mapData, docId) => Product.formMap(mapData!, docId),
        queryPeocess: (query) => query.where('category', isEqualTo: 'Women'));
  }

  @override
  Stream<List<Product>> getMenProducts() {
    return _service.collectionsStream(
        collectionPath: FirestoreApiPath.productsCollection(),
        deMapping: (mapData, docId) => Product.formMap(mapData!, docId),
        queryPeocess: (query) => query.where('category', isEqualTo: 'Men'));
  }

  /// End of product getters =======================

  @override
  Stream<List<DeliveryOption>> deliveryOptions() => _service.collectionsStream(
      collectionPath: FirestoreApiPath.delivryOptions(),
      deMapping: (data, documentId) =>
          DeliveryOption.fromMap(data!, documentId));

  @override
  Stream<List<ShippingAddress>> getShippingAddresses() =>
      _service.collectionsStream(
          collectionPath: FirestoreApiPath.userAddresses(uId),
          deMapping: (data, documentId) =>
              ShippingAddress.fromMap(data!, documentId));
  @override
  Stream<List<ShippingAddress>> getDefaultShippingAddress() {
    return _service.collectionsStream(
      collectionPath: FirestoreApiPath.userAddresses(uId),
      deMapping: (data, documentId) =>
          ShippingAddress.fromMap(data!, documentId),
      queryPeocess: (query) => query.where('isDefault', isEqualTo: true),
    );
  }

  @override
  Future<UserData> getUserData() async {
    return _service
        .documentsStream(
            documentPath: FirestoreApiPath.userDoc(uId),
            deMapping: ((data, documentID) =>
                UserData.fromMap(data!, documentID)))
        .first;
  }

  ///Data setters *******************************
  @override
  Future<void> setUserData(UserData userData) => _service.setData(
      documentPath: FirestoreApiPath.userDoc(userData.uId),
      data: userData.toMap());

  @override
  Future<void> addToCart(UserProduct userProduct) => _service.setData(
      documentPath: FirestoreApiPath.cartProduct(uId, userProduct.id),
      data: userProduct.toMap());

  @override
  Future<void> createOrder(Order order) => _service.setData(
      documentPath: FirestoreApiPath.orderProduct(uId, order.id),
      data: order.toMap());
  @override
  Future<void> addProduct(Product product) => _service.setData(
      documentPath:
          FirestoreApiPath.favouriteCollection(uId, product.productID),
      data: product.toMap());

  @override
  Future<void> saveAddress(ShippingAddress usersAddress) => _service.setData(
      documentPath: FirestoreApiPath.specificAddress(uId, usersAddress.id),
      data: usersAddress.toMap());

  ///Data deleters **********************************
  @override
  Future<void> deleteCartProduct({required UserProduct userProduct}) async {
    _service.deleteData(
        documentPath: FirestoreApiPath.cartProduct(uId, userProduct.id));
  }

  @override
  Future<void> clearCartAfterOrder() async {
    _service.deleteCollection(
        collectionPath: FirestoreApiPath.cartCollection(uId));
  }

  @override
  Future<void> deleteProducts(Product product) async {
    _service.deleteData(
        documentPath:
            FirestoreApiPath.favouriteCollection(uId, product.productID));
  }

  @override
  Future<void> deleteAddress(ShippingAddress address) async {
    _service.deleteData(
        documentPath: FirestoreApiPath.specificAddress(uId, address.id));
  }
}
