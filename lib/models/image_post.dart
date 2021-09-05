class ImagePost {
  final String? imageID;
  // final String? imageName; //
  List<String>? imageTags = [];
  final String? imageUrl; //

  ImagePost({
    this.imageID,
    // this.imageName,
    this.imageTags,
    this.imageUrl,
  });

  factory ImagePost.fromJson(Map<String, dynamic> json) {
    return ImagePost(
      imageID: json['imageID'],
      // imageName: json['imageName'],
      imageTags: List.from(json['imageTags']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageID': imageID,
      // 'imageName': imageName,
      'imageTags': imageTags,
      'imageUrl': imageUrl,
    };
  }
}
