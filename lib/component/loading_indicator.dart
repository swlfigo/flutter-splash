import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? inputColor;

  const LoadingIndicator({super.key, this.inputColor});

  /// Returns the appropriate "loading indicator" icon for the given `platform`.
  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoActivityIndicator(color: inputColor);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      default:
        return const CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) => Center(
        child: _getIndicatorWidget(Theme.of(context).platform),
      );
}
