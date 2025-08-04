import 'dart:convert';

class Slider {
  int? id;
  String? title;
  String? image;
  dynamic btnUrl;

  Slider({this.id, this.title, this.image, this.btnUrl});

  factory Slider.fromMap(Map<String, dynamic> data) => Slider(
        id: data['id'] as int?,
        title: data['title'] as String?,
        image: data['image'] as String?,
        btnUrl: data['btn_url'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'image': image,
        'btn_url': btnUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Slider].
  factory Slider.fromJson(String data) {
    return Slider.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Slider] to a JSON string.
  String toJson() => json.encode(toMap());
}
