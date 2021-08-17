import 'package:flutter/material.dart';
import 'package:shop_app/_base/transalator.dart';

// ignore: must_be_immutable
abstract class BaseStatelessWidget extends StatelessWidget with Translator {
  @override
  Widget build(BuildContext context) {
    initAppLocals(context);
    return baseBuild(context);
  }

  Widget baseBuild(BuildContext context);
}
