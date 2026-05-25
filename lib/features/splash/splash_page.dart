import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';
import '../../services/local_storage_service.dart';
import '../auth/login_page.dart';
import '../home/security_dashboard_home_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});
  static const routePath = '/';

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _logoController;
  late final AnimationController _pulseController;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _logoController.forward();

    _timer = Timer(const Duration(milliseconds: 3000), () {
      if (!mounted) return;
      final token = LocalStorageService().getAuthToken();
      if (token != null && token.isNotEmpty) {
        context.go(SecurityDashboardHomePage.routePath);
      } else {
        context.go(LoginPage.routePath);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _logoController.dispose();
    _pulseController.dispose();
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
                child: _PulsingGlow(
                  controller: _pulseController,
                  size: 260,
                  baseOpacity: p.isDark ? 0.12 : 0.18,
                ),
              ),
              Positioned(
                bottom: -140,
                right: -90,
                child: _PulsingGlow(
                  controller: _pulseController,
                  size: 300,
                  baseOpacity: p.isDark ? 0.10 : 0.14,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: _logoFade,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: _LogoBox(pulse: _pulseController),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SlideTransition(
                      position: _textSlide,
                      child: FadeTransition(
                        opacity: _logoFade,
                        child: Column(
                          children: [
                            Text(
                              isAr ? 'لوحة الأمان' : 'Security Dashboard',
                              style: TextStyle(
                                color: p.text,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              isAr
                                  ? 'حماية. مراقبة. استجابة.'
                                  : 'Secure. Monitor. Respond.',
                              style: TextStyle(
                                color: p.mutedText,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _logoFade,
                      child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
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
  final AnimationController pulse;

  const _LogoBox({required this.pulse});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        final glow = 0.15 + (pulse.value * 0.25);
        return Container(
          height: 96,
          width: 96,
          decoration: BoxDecoration(
            color: p.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: p.border),
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                spreadRadius: 2,
                color: AppColors.primary.withValues(alpha: glow),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Image.asset(
          AppAssets.logo,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.shield_rounded,
            color: AppColors.primary,
            size: 44,
          ),
        ),
      ),
    );
  }
}

class _PulsingGlow extends StatelessWidget {
  final AnimationController controller;
  final double size;
  final double baseOpacity;

  const _PulsingGlow({
    required this.controller,
    required this.size,
    required this.baseOpacity,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final opacity = baseOpacity + (controller.value * 0.06);
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
      },
    );
  }
}
