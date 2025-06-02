class Model {
  final String path;
  final String name;
  final String modeler;
  final String description;
  final Position position;
  final String image;
  final Extents extents;
  final double zoom;

  Model({
    required this.path,
    required this.name,
    required this.modeler,
    required this.description,
    required this.position,
    required this.image,
    required this.extents,
    required this.zoom,
  });

  // Convert JSON map to Model instance
  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      path: json['path'],
      name: json['name'],
      modeler: json['modeler'],
      description: json['description'],
      position: Position.fromJson(json['position']),
      image: json['image'],
      extents: Extents.fromJson(json['extents']),
      zoom: json['zoom'],
    );
  }
}

class Position {
  final double lat;
  final double lon;

  Position({required this.lat, required this.lon});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      lat: json['lat'],
      lon: json['long'], // Note: use 'long' instead of 'lng' in this case
    );
  }
}

class Extents {
  final List<double> southWest;
  final List<double> northEast;

  Extents({required this.southWest, required this.northEast});

  factory Extents.fromJson(Map<String, dynamic> json) {
    return Extents(
      southWest: List<double>.from(json['southWest'] ?? []),
      northEast: List<double>.from(json['northEast'] ?? []),
    );
  }
}
