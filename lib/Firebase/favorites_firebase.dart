import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesFirebase {
  FirebaseFirestore _firebase =
      FirebaseFirestore.instance; //instnacia de abse firebase
  CollectionReference? _favoritesCollection;

  FavoritesFirebase() {
    _favoritesCollection = _firebase.collection('favorites'); //Nos conectamos
  }

  Future<void> insFavorite(Map<String, dynamic> map) async {
    //Insertar
    return _favoritesCollection!.doc().set(map);
  }

  Future<void> updFavorite(Map<String, dynamic> map, String id) async {
    //Actualizar
    return _favoritesCollection!.doc(id).update(map);
  }

  Future<void> delFavorite(String id) async {
    //Borrar
    return _favoritesCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavorites() {
    //Obtener
    return _favoritesCollection!.snapshots();
  }
}
