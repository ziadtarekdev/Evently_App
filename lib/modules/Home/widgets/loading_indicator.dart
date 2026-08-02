import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _currentOverlay;
  static bool _isShowing = false;

  static void show(BuildContext context, {String? message}) {
    if (_isShowing) return;

    _isShowing = true;

    final overlay = Overlay.of(context);

    _currentOverlay = OverlayEntry(
      builder: (_) => _LoadingWidget(message: message),
    );

    overlay.insert(_currentOverlay!);
  }

  static void hide() {
    if (!_isShowing) return;

    _currentOverlay?.remove();
    _currentOverlay = null;
    _isShowing = false;
  }

  static bool get isShowing => _isShowing;
}

class _LoadingWidget extends StatelessWidget {
  final String? message;

  const _LoadingWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        color: Colors.black.withOpacity(.85),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.08),
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: const Icon(
                  Icons.local_airport,
                  color: Colors.white,
                  size: 70,
                ),
              ),

              const SizedBox(height: 30),

              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                message ?? "Preparing your DJ profile...",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}