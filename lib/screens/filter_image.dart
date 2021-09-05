import 'package:flutter/material.dart';
import 'package:mobitek/utils/firestore_service.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class FilterImage extends StatefulWidget {
  @override
  _FilterImageState createState() => _FilterImageState();
}

class _FilterImageState extends State<FilterImage> {
  var firestoreService = FirestoreService();

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
        body:
            // ignore: sized_box_for_whitespace
            Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 40.0,
            ),
            child: Container(),
          ),
        ));
  }
}
