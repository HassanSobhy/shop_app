import 'package:flutter/material.dart';
import 'package:shop_app/_base/transalator.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({
    Key key,
  }) : super(key: key);

  @override
  BaseState createState() {
    return baseCreateState();
  }

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with Translator {
  @override
  Widget build(BuildContext context) {
    initAppLocals(context);
    return baseWidget();
  }

  Widget baseWidget() {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [baseBuild(context)],
      ),
    );
  }

  void changeState() {
    setState(() {});
  }

  @override
  void runChangeState() {
    changeState();
  }

  @override
  BaseState provideTranslate() {
    return this;
  }

  @override
  BuildContext provideContext() {
    return context;
  }

  Widget baseBuild(BuildContext context);
}
