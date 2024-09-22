class FountainModel {
  int? totalCount;
  List<Link>? links;
  List<Record>? records;

  FountainModel({this.totalCount, this.links, this.records});

  factory FountainModel.fromJson(Map<String, dynamic> json) {
    return FountainModel(
      totalCount: json['total_count'],
      links: json['links'] != null
          ? List<Link>.from(json['links'].map((link) => Link.fromJson(link)))
          : [],
      records: json['records'] != null
          ? List<Record>.from(json['records'].map((record) => Record.fromJson(record)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_count': totalCount,
      'links': links?.map((link) => link.toJson()).toList(),
      'records': records?.map((record) => record.toJson()).toList(),
    };
  }
}

class Link {
  String? rel;
  String? href;

  Link({this.rel, this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      rel: json['rel'],
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rel': rel,
      'href': href,
    };
  }
}

class Record {
  List<Link>? links;
  RecordData? record;

  Record({this.links, this.record});

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      links: json['links'] != null
          ? List<Link>.from(json['links'].map((link) => Link.fromJson(link)))
          : [],
      record: json['record'] != null ? RecordData.fromJson(json['record']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'links': links?.map((link) => link.toJson()).toList(),
      'record': record?.toJson(),
    };
  }
}

class RecordData {
  String? id;
  String? timestamp;
  int? size;
  Fields? fields;

  RecordData({this.id, this.timestamp, this.size, this.fields});

  factory RecordData.fromJson(Map<String, dynamic> json) {
    return RecordData(
      id: json['id'],
      timestamp: json['timestamp'],
      size: json['size'],
      fields: json['fields'] != null ? Fields.fromJson(json['fields']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
      'size': size,
      'fields': fields?.toJson(),
    };
  }
}

class Fields {
  String? mapid;
  String? name;
  String? location;
  String? maintainer;
  String? inOperation;
  String? petFriendly;
  String? photoName;
  Geom? geom;
  String? geoLocalArea;
  GeoPoint2d? geoPoint2d;

  Fields({
    this.mapid,
    this.name,
    this.location,
    this.maintainer,
    this.inOperation,
    this.petFriendly,
    this.photoName,
    this.geom,
    this.geoLocalArea,
    this.geoPoint2d,
  });

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(
      mapid: json['mapid'],
      name: json['name'],
      location: json['location'],
      maintainer: json['maintainer'],
      inOperation: json['in_operation'],
      petFriendly: json['pet_friendly'],
      photoName: json['photo_name'],
      geom: json['geom'] != null ? Geom.fromJson(json['geom']) : null,
      geoLocalArea: json['geo_local_area'],
      geoPoint2d: json['geo_point_2d'] != null ? GeoPoint2d.fromJson(json['geo_point_2d']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mapid': mapid,
      'name': name,
      'location': location,
      'maintainer': maintainer,
      'in_operation': inOperation,
      'pet_friendly': petFriendly,
      'photo_name': photoName,
      'geom': geom?.toJson(),
      'geo_local_area': geoLocalArea,
      'geo_point_2d': geoPoint2d?.toJson(),
    };
  }
}

class Geom {
  String? type;
  Geometry? geometry;

  Geom({this.type, this.geometry});

  factory Geom.fromJson(Map<String, dynamic> json) {
    return Geom(
      type: json['type'],
      geometry: json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'geometry': geometry?.toJson(),
    };
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json['type'],
      coordinates: json['coordinates'] != null ? List<double>.from(json['coordinates']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class GeoPoint2d {
  double? lon;
  double? lat;

  GeoPoint2d({this.lon, this.lat});

  factory GeoPoint2d.fromJson(Map<String, dynamic> json) {
    return GeoPoint2d(
      lon: json['lon'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}
