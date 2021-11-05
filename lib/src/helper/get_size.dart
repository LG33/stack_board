import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChange = void Function(Size? size);

class _MeasureSizeRenderObject extends RenderProxyBox {
  _MeasureSizeRenderObject(this.onChange);
  Size? oldSize;
  final OnWidgetSizeChange? onChange;

  @override
  void performLayout() {
    super.performLayout();

    final Size? newSize = child?.size;
    if (oldSize == newSize) {
      return;
    }

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange?.call(newSize);
    });
  }
}

class GetSize extends SingleChildRenderObjectWidget {
  const GetSize({
    Key? key,
    required this.onChange,
    Widget? child,
  }) : super(key: key, child: child);

  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MeasureSizeRenderObject(onChange);
  }
}
