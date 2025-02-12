import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAssetRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserAssetRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Future<void> addUserAsset(UserAsset asset) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('assets')
          .add(asset.toMap());
    } catch (e) {
      throw Exception('Varlık eklenirken hata oluştu: $e');
    }
  }

  Future<void> deleteAsset(String assetId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('assets')
          .doc(assetId)
          .delete();
    } catch (e) {
      throw Exception('Varlık silinirken hata oluştu: $e');
    }
  }

  // Fetch user's assets from Firestore
  Stream<List<UserAsset>> getUserAssets() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('assets')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserAsset.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }
}
