// ignore: file_names
import 'package:flutter/cupertino.dart';

import '../../core/ui.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final Function()? onPressed;
  final Color? color;

  const PrimaryButton({super.key, required this.text, this.onPressed, this.color });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        onPressed: onPressed,
        color: color ?? AppColors.accent,
        child: Text(text),
      ),
    );
  }
}
