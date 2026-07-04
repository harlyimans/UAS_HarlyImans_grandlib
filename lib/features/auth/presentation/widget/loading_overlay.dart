import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
  });

  static const Color primary = Color(0xFF6D4C41);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        if (isLoading)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),

              child: Container(
                color: Colors.black.withOpacity(.35),

                child: Center(
                  child: Container(
                    width: 250,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 28,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(24),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.12),

                          blurRadius: 25,

                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Container(
                          width: 70,

                          height: 70,

                          decoration: BoxDecoration(
                            color: primary.withOpacity(.08),

                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.menu_book_rounded,

                            color: primary,

                            size: 36,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const CircularProgressIndicator(
                          color: primary,
                          strokeWidth: 3,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          message ?? "Mohon tunggu...",

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 16,

                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Sedang memproses permintaan Anda",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.grey.shade600,

                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
