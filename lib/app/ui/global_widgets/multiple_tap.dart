import 'dart:async';

import 'package:flutter/material.dart';

class AppMultipleTap extends StatefulWidget {
  final Widget child;
  final VoidCallback onMultipleTap;
  final int taps;
  final Duration duration;

  const AppMultipleTap({
    super.key,
    required this.child,
    required this.onMultipleTap,
/// feel free to override these values
    this.taps = 3,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<AppMultipleTap> createState() => _AppMultipleTapState();
}

class _AppMultipleTapState extends State<AppMultipleTap> {
/// in _count we store current number of taps
  int _count = 0;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        if (_timer == null) _startTimer();
        _count++;
      },
      child: widget.child,
    );
  }

  void _startTimer() {
    _timer = Timer(widget.duration, () {
/// you can change this condition to ==, if you need 100% match
      if (_count >= widget.taps) {
        widget.onMultipleTap.call();
      }
      _timer = null;
      _count = 0;
    });
  }
}