import 'package:flutter/material.dart';

import 'package:shop_app/_base/widgets/base_stateful_widget.dart';
import 'package:shop_app/_base/widgets/base_stateless_widget.dart';

class BaseStatefulExampleWidget extends BaseStatefulWidget {
  @override
  BaseState<BaseStatefulExampleWidget> baseCreateState() {
    return _BaseStatefulExampleWidgetState();
  }
}

class _BaseStatefulExampleWidgetState
    extends BaseState<BaseStatefulExampleWidget> {
  String txt = 'tneen';

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text(txt),
          onPressed: () {
            setState(() {
              txt = 'ChangedText';
            });
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BaseStatelessExampleWidget extends BaseStatelessWidget {
  String txt = 'tneen';

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      child: Center(
        child: Text(txt),
      ),
    );
  }
}
