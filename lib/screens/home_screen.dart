import 'package:flutter/material.dart';
import 'package:mobitek/screens/add_image_post.dart';
import 'package:mobitek/screens/filter_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "MobiTek Photo Uploader",
          style: TextStyle(color: Colors.black),
        ),
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60.0),
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.black87,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddImagePost()));
                },
                child: const Text('Add Image')),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60.0),
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.black87,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FilterImage()));
                },
                child: const Text('Image List')),
          ],
        ),
      ),
    );
  }
}
