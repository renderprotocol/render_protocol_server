import 'dart:typed_data';

import 'package:fixnum/fixnum.dart' show Int64;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rp_generated_dart/rp_generated_dart.dart';

/// Represents a render tree document stored in MongoDB.
///
/// The [tree] field holds the deserialized [RPWidget] root.
/// Raw protobuf bytes are stored in the database under `tree_data`
/// as [BsonBinary], and deserialized on read.
///
/// Documents in the `render_trees` collection have the following shape:
/// ```
/// {
///   "id":        String,       // user-defined tree ID
///   "tree_data":  BsonBinary,   // raw protobuf bytes (RPWidget)
///   "version":    String,       // UUID v4, bumped on every write
///   "created_at": DateTime,
///   "updated_at": DateTime,
/// }
/// ```

class RenderTreeDocument {
  const RenderTreeDocument({
    required this.id,
    required this.tree,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Application-defined render tree identifier.
  final String id;

  /// The deserialized root widget of the render tree.
  final RPWidget tree;

  /// Version tag (UUID v4), regenerated on every write.
  final String version;

  /// Timestamp of initial creation.
  final DateTime createdAt;

  /// Timestamp of last update.
  final DateTime updatedAt;

  factory RenderTreeDocument.fromJSON(Map json) {
    final bsonBinary = json['tree_data'] as BsonBinary;
    final bytes = Uint8List.fromList(bsonBinary.byteList);
    final tree = RPWidget.fromBuffer(bytes);
    final createdAt = (json['created_at'] as Int64).toInt();
    final updatedAt = (json['updated_at'] as Int64).toInt();

    return .new(
      id: json['_id'] as String,
      tree: tree,
      version: json['version'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }

  Map<String, dynamic> toJSON() {
    final bytes = tree.writeToBuffer();
    final bsonBinary = BsonBinary.from(bytes);

    return {
      '_id': id,
      'tree_data': bsonBinary,
      'version': version,
      'created_at': Int64(createdAt.millisecondsSinceEpoch),
      'updated_at': Int64(updatedAt.millisecondsSinceEpoch),
    };
  }
}
