import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobitek/models/image_post.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  //Add or Update a Single Image Item
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
  Stream<List<ImagePost>> get getImagePostList {
    return _firestore.collection('images').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => ImagePost.fromJson(doc.data())).toList());
  }

  //Update Views
  Future<void> incrementViews(String _imageID, int currentViews) {
    var options = SetOptions(merge: true);
    return _firestore
        .collection('images')
        .doc(_imageID)
        .set({'imageViews': currentViews + 1}, options);
  }
}
