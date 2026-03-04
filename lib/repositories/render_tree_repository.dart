import 'package:mongo_dart/mongo_dart.dart';
import 'package:render_protocol_server/core/db/rp_database.dart';
import 'package:render_protocol_server/repositories/models/render_tree_document.dart';

/// Repository for reading render trees stored as raw protobuf bytes in MongoDB.

class RenderTreeRepository {
  const RenderTreeRepository({required this.db});

  final RPDatabase db;

  // ───────────────────────────────────────────────
  // Read
  // ───────────────────────────────────────────────

  /// Fetches a render tree by [id].
  ///
  /// Returns `null` if no document with the given [id] exists.
  Future<RenderTreeDocument?> read(String id) async {
    final doc = await _collection.findOne(where.eq('_id', id));
    if (doc == null) return null;
    return .fromJSON(doc);
  }

  /// Fetches only the version string for the render tree with the given [id].
  ///
  /// Returns `null` if no document exists. Useful for cache-check flows
  /// where the full tree deserialization can be skipped.
  Future<String?> readVersion(String id) async {
    final doc = await _collection.findOne(
      where.eq('_id', id).fields(['version']),
    );
    return doc?['version'] as String?;
  }

  // ───────────────────────────────────────────────
  // Helpers
  // ───────────────────────────────────────────────

  DbCollection get _collection => db.collection("render_trees");
}
