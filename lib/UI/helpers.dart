import 'package:flutter/material.dart';

Route navegarMapaFadeIn(BuildContext context, Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (___, __, _) => widget,
    transitionDuration: const Duration(microseconds: 300),
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
      );
    },
  );
}
