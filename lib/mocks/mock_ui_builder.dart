import 'package:rp_generated_dart/rp_generated_dart.dart';
import 'package:rp_utils_dart/rp_utils_dart.dart';

abstract interface class MockUIBuilder {
  static RPWidget listOfCards() {
    final textStyle = RPTextStyle();
    textStyle.fontSize = 18.0;
    textStyle.fontWeight = .RP_FONT_WEIGHT_BOLD;

    final text = RPText();
    text.value = "Hello world from RP!";
    text.style = textStyle;

    final opacity = RPOpacity();
    opacity.value = 0.7;
    opacity.child = text.makeWidget();

    final image = RPImage();
    image.url = "https://picsum.photos/300/200";

    final bgColor = RPColor();
    bgColor.red = 0;
    bgColor.green = 128;
    bgColor.blue = 128;

    final clipShape = RPClipShape();
    clipShape.roundedRectangle = .new()..radius = 12.0;
    final clip = RPClip();
    clip.shape = clipShape;
    clip.type = .RP_CLIP_TYPE_ANTI_ALIAS;
    clip.child = image.makeWidget();

    final expanded = RPExpanded();
    expanded.child = clip.makeWidget();

    final toggle = RPToggle()..enabled = true;

    final row1 = RPRow();
    row1.children.add(opacity.makeWidget());
    row1.children.add(RPSpacer().makeWidget());
    row1.children.add(toggle.makeWidget());

    final row2 = rpRow(
      children: [
        expanded.makeWidget(),
        expanded.makeWidget(),
      ],
    );

    final column = rpColumn(
      children: [
        row1.makeWidget(),
        row2.makeWidget(),
      ],
      alignment: .RP_AXIS_ALIGNMENT_LEADING,
    );

    final card = RPCard();
    card.child = column.makeWidget();
    card.backgroundColor = rpColorTeal;

    final box = RPSizeBox();
    box.height = 212.0;
    box.child = card.makeWidget();

    final lazyList = RPLazyList();
    lazyList.spacing = 2.5;
    lazyList.separator = rpDivider(color: rpColorGray).makeWidget();
    lazyList.axis = .RP_AXIS_VERTICAL;
    for (int i = 0; i < 1000; i++) {
      lazyList.children.add(box.makeWidget());
    }

    return lazyList.makeWidget().withPadding(8.0);
  }
}
