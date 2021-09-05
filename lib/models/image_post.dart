class ImagePost {
  final String? imageID;
  int imageViews = 0; //
  List<String>? imageTags = [];
  final String? imageUrl; //

  ImagePost({
    this.imageID,
    this.imageViews = 0,
    this.imageTags,
    this.imageUrl,
  });

  factory ImagePost.fromJson(Map<String, dynamic> json) {
    return ImagePost(
      imageID: json['imageID'],
      imageViews: json['imageViews'].toInt(),
      imageTags: List.from(json['imageTags']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageID': imageID,
      'imageViews': imageViews,
      'imageTags': imageTags,
      'imageUrl': imageUrl,
    };
  }
}
