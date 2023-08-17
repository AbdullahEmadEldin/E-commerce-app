import 'package:e_commerce_app/Models/product.dart';
import 'package:e_commerce_app/Services/firestore_services.dart';
import 'package:e_commerce_app/Utilities/api_paths.dart';

abstract class Database {
  Stream<List<Product>> salesProductStream();
  Stream<List<Product>> newProductStream();
}

///this calss' methods will control and call methods from firestore srvices
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
}
