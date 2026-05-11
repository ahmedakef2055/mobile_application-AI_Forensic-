import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/settings_provider.dart';
import '../auth/login_page.dart';

class SigningOutSplashPage extends ConsumerStatefulWidget {
  const SigningOutSplashPage({super.key});
  static const routePath = '/signing-out';

  @override
  ConsumerState<SigningOutSplashPage> createState() =>
      _SigningOutSplashPageState();
}

class _SigningOutSplashPageState extends ConsumerState<SigningOutSplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      context.go(LoginPage.routePath);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final settings = ref.watch(settingsProvider);
    final isAr = settings.isArabic;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [p.bgTop, p.background],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -120,
                left: -80,
                child: _GlowCircle(
                    size: 260, opacity: p.isDark ? 0.12 : 0.18),
              ),
              Positioned(
                bottom: -140,
                right: -90,
                child: _GlowCircle(
                    size: 300, opacity: p.isDark ? 0.10 : 0.14),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _LogoBox(),
                    const SizedBox(height: 18),
                    Text(
                      isAr ? 'جارٍ تسجيل الخروج...' : 'Signing out...',
                      style: TextStyle(
                        color: p.text,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isAr ? 'إلى اللقاء 👋' : 'See you soon 👋',
                      style: TextStyle(
                        color: p.mutedText,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoBox extends StatelessWidget {
  const _LogoBox();

  @override
  Widget build(BuildContext context) {
    final p = c(context);

    return Container(
      height: 92,
      width: 92,
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: p.border),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 2,
            color: AppColors.primary.withValues(alpha: 0.20),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Image.asset(
          AppAssets.logo,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(
            Icons.shield_rounded,
            color: AppColors.primary,
            size: 44,
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final double opacity;

  const _GlowCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: opacity),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
