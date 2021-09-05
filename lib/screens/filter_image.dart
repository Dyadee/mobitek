// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobitek/models/image_post.dart';
import 'package:mobitek/utils/firestore_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class FilterImage extends StatefulWidget {
  @override
  _FilterImageState createState() => _FilterImageState();
}

class _FilterImageState extends State<FilterImage> {
  var firestoreService = FirestoreService();
  List<ImagePost> _images = [];
  List<ImagePost> _imagesList = [];
  List<ImagePost> myImages = [];

  final kHintTextStyle = const TextStyle(
    color: Colors.black26,
    fontFamily: 'OpenSans',
  );

  final _imageTagsController = TextEditingController();

  @override
  void dispose() {
    _imageTagsController.dispose();
    super.dispose();
  }

  final _defaultBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black),
  );

  final _focusedBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black),
  );

  final _focusedErrorBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.redAccent),
  );

  @override
  Widget build(BuildContext context) {
    _images = Provider.of<List<ImagePost>>(context);
    if (_imageTagsController.text.isEmpty) {
      setState(() {
        _imagesList = _images;
      });
    } else {
      myImages = _images
          .where((element) =>
              element.imageTags!.contains(_imageTagsController.text))
          .toList();
      setState(() {
        _imagesList = myImages;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _imageTagsController,
          onChanged: (String val) {
            // ignore: avoid_print
            print(val);
            if (val.isNotEmpty) {
              String value = val.toString();
              myImages = _images
                  .where((element) => element.imageTags!.contains(value))
                  .toList();

              setState(() {
                _imagesList = myImages;
              });
            } else {
              setState(() {
                _imagesList = _images;
              });
            }
            if (_imageTagsController.text.isNotEmpty) {
              setState(() {});
            }

            // ignore: avoid_print
            print(_imagesList);
            // ignore: avoid_print, avoid_function_literals_in_foreach_calls
            myImages.forEach((val) => print(val.imageID));
          },
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
            fontSize: 12.0,
          ),
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black),
            // fillColor: Colors.amber,
            focusedErrorBorder: _focusedErrorBorder,
            focusedBorder: _focusedBorder,
            border: _defaultBorder,
            enabledBorder: _defaultBorder,
            contentPadding: const EdgeInsets.all(8.0),
            hintText: "Search images by tags",
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
              itemCount: _imagesList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  // color: Colors.blue,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      // ignore: avoid_print
                      print(_imagesList[index].imageTags);
                      // ignore: avoid_print
                      print(_imagesList[index].imageTags!.contains("water"));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.yellowAccent,
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
                      // height: 400,
                      // width: double.infinity,
                      child: _imagesList[index].imageUrl != null
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                        _imagesList[index].imageUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            )
                          : const Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                );
              })),
    );
  }

  void filterList(String value) {
    setState(() {
      _imagesList =
          _imagesList.where((post) => post.imageTags!.contains(value)).toList();
    });
  }
}
