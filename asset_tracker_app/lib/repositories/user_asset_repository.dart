import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAssetRepository {
  Future<void> addUserAsset(UserAsset asset);
  Future<void> deleteAsset(String assetId);
  Stream<List<UserAsset>> getUserAssets();
}

class UserAssetRepositoryImpl extends UserAssetRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  static const String usersCollection = 'users';
  static const String assetsCollection = 'assets';

  UserAssetRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> addUserAsset(UserAsset asset) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(_auth.currentUser?.uid)
          .collection(assetsCollection)
          .add(asset.toMap());
    } catch (e) {
      throw Exception(LocalStrings.addAssetError + e.toString());
    }
  }

  @override
  Future<void> deleteAsset(String assetId) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(_auth.currentUser?.uid)
          .collection(assetsCollection)
          .doc(assetId)
          .delete();
    } catch (e) {
      throw Exception(LocalStrings.deleteAssetError + e.toString());
    }
  }

  @override
  Stream<List<UserAsset>> getUserAssets() {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return Stream.value([]);
    }

    try {
      final stream = _firestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(assetsCollection)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id; // Ensure ID is set
          return UserAsset.fromMap({...data, 'id': doc.id});
        }).toList();
      });

      return stream;
    } catch (e) {
      return Stream.value([]);
    }
  }
}
