import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobitek/models/image_post.dart';
import 'package:mobitek/utils/firestore_service.dart';
import 'package:mobitek/utils/storage_service.dart';
import 'package:nanoid/nanoid.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class AddImagePost extends StatefulWidget {
  @override
  _AddImagePostState createState() => _AddImagePostState();
}

class _AddImagePostState extends State<AddImagePost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var firestoreService = FirestoreService();
  final _nanoID = nanoid(7);

  final kHintTextStyle = const TextStyle(
    color: Colors.black26,
    fontFamily: 'OpenSans',
  );

  final _imageTagsController = TextEditingController();

  File? _imageFile;
  final picker = ImagePicker();

  Future<PickedFile?> pickImage() async {
    final pickedFile = await picker
        .getImage(
          source: ImageSource.gallery,
          maxHeight: 512,
          maxWidth: 512,
          // imageQuality: 90,
        )
        .onError((error, stackTrace) => null);
    try {
      setState(() {
        _imageFile = File(pickedFile!.path);
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void dispose() {
    _imageTagsController.dispose();
    super.dispose();
  }

  final _focusedBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.grey),
  );

  final _focusedErrorBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.redAccent),
  );

  Widget buildImageTags(
    String name,
    String capName,
    String label,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: _imageTagsController,
          validator: (String? val) {
            if (val!.isEmpty) {
              return "Please enter $name";
            } else if (val.length < 6) {
              return "$capName is too short";
            } else {
              return null;
            }
          },
          style: TextStyle(
            color: Colors.grey[300],
            fontFamily: 'OpenSans',
            fontSize: 12.0,
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[400]),
            fillColor: Colors.amber,
            focusedErrorBorder: _focusedErrorBorder,
            focusedBorder: _focusedBorder,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            contentPadding: const EdgeInsets.all(20.0),
            hintText: "Enter your item's $name",
            hintStyle: kHintTextStyle,
          ),
        ),
      ],
    );
  }

  Widget buildItemImageCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Item Image',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.add_a_photo,
                    size: 24,
                    color: Colors.grey,
                  ),
                  onPressed: pickImage,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 12.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.amber[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.none,
            // alignment: Alignment.center,
            height: 180,
            width: double.infinity,
            child: _imageFile != null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey,
                    ),
                    onPressed: pickImage,
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildImageDetailsCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Image Tags',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 12.0),
          buildImageTags(
            "item name",
            "Item Name",
            "comma separated tags",
          ),
        ],
      ),
    );
  }

  Widget buildSaveImagePostBtn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(60.0),
        primary: Colors.grey,
        onPrimary: Colors.grey[100],
      ),
      onPressed: () {
        if (_formKey.currentState!.validate() && _imageFile != null) {
          _formKey.currentState!.save();

          var _imagePost = ImagePost(
            imageID: _nanoID,
            imageTags: _imageTagsController.text.trim().split(','),
          );

          firestoreService.setImagePost(_imagePost).whenComplete(() {
            if (_imageFile != null) {
              uploadImage(_imageFile!, _imagePost.imageID!)
                  .then((_itemImageUrl) {
                firestoreService.setItemImageUrl(
                    _itemImageUrl!, _imagePost.imageID!);
              });
            }
            const snackBar = SnackBar(
              content: Text('Item Profile Saved Successfully!'),
              backgroundColor: Colors.grey,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          });
        } else {
          const snackBar = SnackBar(
            content: Text(
              'Something went wrong. Please check all fields and your network connection.',
              style: TextStyle(color: Colors.grey),
            ),
            backgroundColor: Colors.amberAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text(
        'SAVE',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Add Image",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: kLightBackgroundCityDash,
                  color: Colors.white,
                ),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildItemImageCard(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      buildImageDetailsCard(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      buildSaveImagePostBtn(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
