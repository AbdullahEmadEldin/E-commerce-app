import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Models/user_product.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/Utilities/api_paths.dart';

import '../Models/user.dart';

abstract class Database {
  Stream<List<Product>> salesProductStream();
  Stream<List<Product>> newProductStream();
  Stream<List<UserProduct>> myBag();
  Future<void> setUserData(UserData userData);
  Future<void> addToCart(UserProduct userProduct);
}

///this calss' methods will control and call methods from firestore srvices
/////////***************The one and the only one *******************/////////
class FirestoreDatabase implements Database {
  final String uId;
  FirestoreDatabase(this.uId);

  final _service = FirestoreServices.instance;

  @override
  Stream<List<Product>> salesProductStream() {
    return _service.collectionsStream(
      collectionPath: ApiPath.productsCollection(),
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
  Future<void> setUserData(UserData userData) => _service.setData(
      documentPath: ApiPath.userDoc(userData.uId), data: userData.toMap());

  @override
  Future<void> addToCart(UserProduct userProduct) => _service.setData(
      documentPath: ApiPath.cartProductCollection(uId, userProduct.id),
      data: userProduct.toMap());

  @override
  Stream<List<UserProduct>> myBag() => _service.collectionsStream(
      collectionPath: ApiPath.cartCollection(uId),
      deMapping: ((data, documentID) =>
          UserProduct.fromMap(data!, documentID)));
}
