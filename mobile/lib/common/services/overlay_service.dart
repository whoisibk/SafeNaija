import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/widgets/toast_widget.dart';

@lazySingleton
class OverlayService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  OverlayEntry? _overlayEntry;

  void show(
    ToastType type,
    String title, {
    String? message,
    Duration duration = const Duration(seconds: 4),
  }) {
    // Dismiss existing overlay if any
    hide();

    final context = navigatorKey.currentContext;
    if (context == null) return;

    final overlayState = navigatorKey.currentState?.overlay;
    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: ToastWidget(
            type: type,
            title: title,
            message: message,
            onDismiss: hide,
          ),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);

    Future.delayed(duration, () {
      if (_overlayEntry != null && _overlayEntry!.mounted) {
        hide();
      }
    });
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
