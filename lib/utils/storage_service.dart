import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final _storage = FirebaseStorage.instance;

//--Upload Image--//

Future<String?> uploadImage(File file, String imageID) async {
  try {
    UploadTask uploadTask =
        _storage.ref().child('images/$imageID/$imageID').putFile(file);

    String downloadUrl = await (await uploadTask).ref.getDownloadURL();
    return downloadUrl;
  } on FirebaseException catch (e) {
    return e.message;
  }
}

//--Delete Item Image--//

Future<String?> deleteItemImage(String itemID, String merchantID) async {
  try {
    _storage
        .ref()
        .child('product_items/$merchantID/item_profile/$itemID')
        .delete();
  } on FirebaseException catch (e) {
    return e.message;
  }
}
