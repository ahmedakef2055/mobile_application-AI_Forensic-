import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_button.dart';

class OnboardingPage extends StatefulWidget {
  static const routePath = '/onboarding';
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late AppPalette _p;
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'مرحبا بك',
      description: 'مرحبا بك في لوحة تحكم الأمان. اكتشف ميزات متقدمة لحماية البيانات',
      icon: Icons.security,
      color: Color(0xFF6366F1),
    ),
    OnboardingItem(
      title: 'المراقبة الذكية',
      description: 'تابع التهديدات الأمنية بالوقت الفعلي مع الذكاء الاصطناعي المتقدم',
      icon: Icons.radar,
      color: Color(0xFF8B5CF6),
    ),
    OnboardingItem(
      title: 'الإشعارات الفورية',
      description: 'احصل على تنبيهات فورية عند اكتشاف أي تهديدات محتملة',
      icon: Icons.notifications_active,
      color: Color(0xFFEC4899),
    ),
    OnboardingItem(
      title: 'ابدأ الآن',
      description: 'انضم إلى آلاف المستخدمين الذين يثقون بنا لأمانهم',
      icon: Icons.rocket_launch,
      color: Color(0xFFF59E0B),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _p = c(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_p.bgTop, _p.bgBottom],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_items[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.s24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _items.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s4,
                        ),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : _p.muted,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.s32),
                  if (_currentPage == _items.length - 1)
                    AppButton(
                      label: 'ابدأ الآن',
                      onPressed: () => context.go('/login'),
                      prefixIcon: Icon(Icons.rocket_launch_rounded, color: Colors.white),
                    )
                  else
                    Row(
                      children: [
                        if (_currentPage > 0)
                          Expanded(
                            child: AppButton(
                              label: 'السابق',
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              variant: ButtonVariant.outline,
                            ),
                          ),
                        SizedBox(width: _currentPage > 0 ? AppSpacing.s12 : 0),
                        Expanded(
                          child: AppButton(
                            label: 'التالي',
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            suffixIcon: Icon(Icons.arrow_back_rounded, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              key: ValueKey(item.title),
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.6 + (value * 0.4),
                  child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
                );
              },
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      item.color.withOpacity(0.25),
                      item.color.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: item.color.withOpacity(0.25),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  item.icon,
                  size: 64,
                  color: item.color,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.s40),
            TweenAnimationBuilder<double>(
              key: ValueKey('${item.title}_text'),
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.s16),
                  Text(
                    item.description,
                    style: AppTextStyles.body.copyWith(
                      color: _p.mutedText,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
