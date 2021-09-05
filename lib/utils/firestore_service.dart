import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobitek/models/image_post.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  //**----CityDash Product Items----**//

  //Add or Update a Single Product Item
  Future<void> setImagePost(ImagePost imagePost) {
    var options = SetOptions(merge: true);

    return _firestore
        .collection('images')
        .doc(imagePost.imageID)
        .set(imagePost.toMap(), options);
  }

  //Update a Single Item Image URL
  Future<void> setItemImageUrl(String _itemImageUrl, String _imageID) {
    var options = SetOptions(merge: true);

    return _firestore
        .collection('images')
        .doc(_imageID)
        .set({'imageUrl': _itemImageUrl}, options);
  }

  //Get List of ImagePosts
  Stream<List<ImagePost>> get getImagePost {
    return _firestore.collection('images').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ImagePost.fromJson(doc.data())).toList());
  }

  //Get List of Product Items by User ID
  Stream<List<ImagePost>> getProductItemListByUserId(String userID) {
    return _firestore
        .collection('images')
        .where('userID', isEqualTo: userID)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ImagePost.fromJson(doc.data()))
            .toList());
  }

  //Get Single Product Items by Item ID
  Stream<ImagePost> getProductItemByItemID(String itemID) {
    return _firestore
        .collection('product_items')
        .where('itemID', isEqualTo: itemID)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ImagePost.fromJson(doc.data()))
            .toList()
            .first);
  }
}
