import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast extends StatelessWidget {
  final String message;
  const Toast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    toastification.showCustom(
      autoCloseDuration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 500),
      alignment: Alignment.topCenter,
      animationBuilder: (context, animation, alignment, child) =>
          FadeTransition(opacity: animation, child: child),
      builder: (BuildContext context, ToastificationItem item) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(1),
                      blurRadius: 10,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: IntrinsicWidth(
                  child: Text(
                    maxLines: 1,
                    message,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    return Container(); // Return an empty container as a placeholder
  }
}

ToastificationItem getToast(String msg) {
  return toastification.showCustom(
    autoCloseDuration: const Duration(seconds: 4),
    animationDuration: const Duration(milliseconds: 500),
    alignment: Alignment.topCenter,
    animationBuilder: (context, animation, alignment, child) =>
        FadeTransition(opacity: animation, child: child),
    builder: (BuildContext context, ToastificationItem item) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(1),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: IntrinsicWidth(
                child: Text(
                  maxLines: 1,
                  msg,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
