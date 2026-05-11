import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum AppToastKind { info, success, warning, error }

class AppToast {
  AppToast._();

  /// Shows a centered, floating toast in the middle of the screen.
  /// Auto-dismisses after [duration] and is also tap-to-dismiss.
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    AppToastKind kind = AppToastKind.info,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry entry;

    final controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 250),
    );

    void dismiss() async {
      await controller.reverse();
      entry.remove();
      controller.dispose();
    }

    entry = OverlayEntry(
      builder: (ctx) {
        return _ToastWidget(
          message: message,
          title: title,
          kind: kind,
          animation: controller,
          onTap: dismiss,
        );
      },
    );

    overlay.insert(entry);
    controller.forward();
    Future.delayed(duration, () {
      if (entry.mounted) dismiss();
    });
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final String? title;
  final AppToastKind kind;
  final Animation<double> animation;
  final VoidCallback onTap;

  const _ToastWidget({
    required this.message,
    required this.title,
    required this.kind,
    required this.animation,
    required this.onTap,
  });

  IconData get _icon {
    switch (kind) {
      case AppToastKind.success:
        return Icons.check_circle_rounded;
      case AppToastKind.warning:
        return Icons.warning_amber_rounded;
      case AppToastKind.error:
        return Icons.error_rounded;
      case AppToastKind.info:
        return Icons.info_rounded;
    }
  }

  Color get _accent {
    switch (kind) {
      case AppToastKind.success:
        return const Color(0xFF34C759);
      case AppToastKind.warning:
        return const Color(0xFFFF9500);
      case AppToastKind.error:
        return const Color(0xFFFF3B30);
      case AppToastKind.info:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = Curves.easeOutCubic.transform(animation.value);
        return Positioned.fill(
          child: IgnorePointer(
            ignoring: animation.value < 0.5,
            child: Stack(
              children: [
                // Blurred backdrop
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onTap,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10 * t,
                        sigmaY: 10 * t,
                      ),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.30 * t),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Opacity(
                    opacity: t,
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * t),
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.82,
                            minWidth: 220,
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                          decoration: BoxDecoration(
                            color: p.bgTop,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: _accent.withValues(alpha: 0.35),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.30),
                                blurRadius: 28,
                                offset: const Offset(0, 8),
                              ),
                              BoxShadow(
                                color: _accent.withValues(alpha: 0.25),
                                blurRadius: 30,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: _accent.withValues(alpha: 0.18),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _accent.withValues(alpha: 0.4),
                                    width: 1.4,
                                  ),
                                ),
                                child: Icon(_icon,
                                    color: _accent, size: 30),
                              ),
                              const SizedBox(height: 14),
                              if (title != null) ...[
                                Text(
                                  title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: p.text,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 6),
                              ],
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: title != null
                                      ? p.mutedText
                                      : p.text,
                                  fontSize: 13.5,
                                  fontWeight: title != null
                                      ? FontWeight.w500
                                      : FontWeight.w600,
                                  height: 1.5,
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
            ),
          ),
        );
      },
    );
  }
}
