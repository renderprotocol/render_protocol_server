import 'package:rp_generated_dart/rp_generated_dart.dart';
import 'package:uuid/uuid.dart';

abstract class RPUtils {
  static RPWidget makeWidgetWithID({String? id}) {
    final widget = RPWidget();
    widget.id = id ?? Uuid().v1();
    return widget;
  }
}
