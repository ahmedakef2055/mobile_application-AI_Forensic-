import 'dart:ui';
import 'package:flutter/material.dart';

/// Drop-in replacement for `showDialog` that adds a blurred backdrop
/// behind the dialog while keeping the rest of the API identical.
Future<T?> showBlurredDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  double sigma = 10,
  Color barrierColor = const Color(0x4D000000),
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (ctx, anim, secAnim) => builder(ctx),
    transitionBuilder: (ctx, anim, secAnim, child) {
      final curved = Curves.easeOutCubic.transform(anim.value);
      return Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: sigma * curved,
                sigmaY: sigma * curved,
              ),
              child: Container(
                color: Color.fromRGBO(
                  0,
                  0,
                  0,
                  barrierColor.a * curved,
                ),
              ),
            ),
          ),
          Opacity(
            opacity: curved,
            child: Transform.scale(
              scale: 0.94 + 0.06 * curved,
              child: child,
            ),
          ),
        ],
      );
    },
  );
}
