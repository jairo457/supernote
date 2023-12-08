import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseFirebase {
  FirebaseFirestore _firebase =
      FirebaseFirestore.instance; //instnacia de abse firebase
  CollectionReference? _UsersCollection;

  DatabaseFirebase() {
    _UsersCollection = _firebase.collection('Users'); //Nos conectamos
  }

  Future<void> insFavorite(Map<String, dynamic> map) async {
    //Insertar
    return _UsersCollection!.doc().set(map);
  }

  Future<void> updFavorite(Map<String, dynamic> map, String id) async {
    //Actualizar
    return _UsersCollection!.doc(id).update(map);
  }

  Future<void> delFavorite(String id) async {
    //Borrar
    return _UsersCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavorites() {
    //Obtener
    return _UsersCollection!.snapshots();
  }

  Future<QuerySnapshot> getUserData(ema) async {
    //Obtener
    return _UsersCollection!.where("correo", isEqualTo: ema).get();
  }
}
