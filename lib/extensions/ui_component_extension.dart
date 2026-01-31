import 'package:rp_generated_dart/rp_generated_dart.dart';
import 'package:rp_utils_dart/rp_utils_dart.dart';

extension RPRowExtension on RPRow {
  RPWidget makeWidget() {
    final widget = RPUtils.makeWidgetWithID();
    widget.row = this;
    return widget;
  }
}

extension RPColumnExtension on RPColumn {
  RPWidget makeWidget() {
    final widget = RPUtils.makeWidgetWithID();
    widget.column = this;
    return widget;
  }
}

extension RPStackExtension on RPStack {
  RPWidget makeWidget() {
    final widget = RPUtils.makeWidgetWithID();
    widget.stack = this;
    return widget;
  }
}

extension RPTextExtension on RPText {
  RPWidget makeWidget() {
    final widget = RPUtils.makeWidgetWithID();
    widget.text = this;
    return widget;
  }
}

extension RPImageExtension on RPImage {
  RPWidget makeWidget() {
    final widget = RPUtils.makeWidgetWithID();
    widget.image = this;
    return widget;
  }
}
