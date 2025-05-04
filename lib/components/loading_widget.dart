import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../shared/theme.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  const LoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? MyTheme.blackColor,
    );
  }
}
