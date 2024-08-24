class ImageDataClass {
  final String publicId;
  final String url;

  ImageDataClass({required this.publicId, required this.url});

  ImageDataClass copyWith({
    String? publicId,
    String? url,
  }) {
    return ImageDataClass(
      publicId: publicId ?? this.publicId,
      url: url ?? this.url,
    );
  }

  factory ImageDataClass.fromJson(Map<String, dynamic> json) {
    return ImageDataClass(
      publicId: json['public_id'],
      url: json['url'],
    );
  }
  factory ImageDataClass.fromMap(Map<String, dynamic> map) {
    return ImageDataClass(
      publicId: map['public_id'] ?? "",
      url: map['url'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageDataClass &&
        other.publicId == publicId &&
        other.url == url;
  }

  @override
  int get hashCode {
    return publicId.hashCode ^ url.hashCode;
  }

  @override
  String toString() {
    return 'ImageDataClass(publicId: $publicId, url: $url)';
  }
}
