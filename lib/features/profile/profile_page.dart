import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_toast.dart';
import '../../core/widgets/blurred_dialog.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';
import '../info/info_pages.dart';

class ProfilePage extends ConsumerWidget {
  static const routePath = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final p = c(context);
    String t(String k) => AppStrings.get(k, settings.locale);

    return Scaffold(
      backgroundColor: p.background,
      appBar: AppBarWidget(
        title: t('profile.title'),
        subtitle: 'بيانات ملفك الشخصي والإعدادات',
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 8),
            sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: p.background,
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _ProfileHeader(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SectionLabel(text: t('profile.title')),
                _MenuItem(
                  icon: Icons.shield_outlined,
                  color: const Color(0xFF34C759),
                  title: t('profile.security'),
                  subtitle: t('profile.security.sub'),
                  onTap: () => _comingSoon(context, ref),
                ),
                _MenuItem(
                  icon: Icons.notifications_none_rounded,
                  color: const Color(0xFFFFCC00),
                  title: t('profile.notifications'),
                  subtitle: t('profile.notifications.sub'),
                  onTap: () => _comingSoon(context, ref),
                ),
                const SizedBox(height: 18),
                _SectionLabel(
                    text: settings.isArabic ? 'التخصيص' : 'Customization'),
                _MenuItem(
                  icon: Icons.language_rounded,
                  color: const Color(0xFF00C7FF),
                  title: t('profile.language'),
                  subtitle: settings.isArabic ? 'العربية' : 'English',
                  trailingBadge: settings.isArabic ? 'AR' : 'EN',
                  onTap: () => _showLanguageDialog(context, ref),
                ),
                _MenuItem(
                  icon: settings.isDark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: settings.isDark
                      ? const Color(0xFF7B6BFF)
                      : const Color(0xFFFF9500),
                  title: t('profile.appearance'),
                  subtitle: settings.isDark
                      ? t('theme.dark')
                      : t('theme.light'),
                  onTap: () => _showThemeDialog(context, ref),
                  trailing: Switch.adaptive(
                    value: settings.isDark,
                    onChanged: (v) {
                      ref.read(settingsProvider.notifier).setThemeMode(
                            v ? AppThemeMode.dark : AppThemeMode.light,
                          );
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 18),
                _SectionLabel(
                    text: settings.isArabic ? 'الدعم والمعلومات' : 'Support & Info'),
                _MenuItem(
                  icon: Icons.help_outline_rounded,
                  color: const Color(0xFF34C759),
                  title: t('profile.help'),
                  subtitle: t('profile.help.sub'),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HelpPage()),
                  ),
                ),
                _MenuItem(
                  icon: Icons.info_outline_rounded,
                  color: AppColors.primary,
                  title: t('profile.about'),
                  subtitle: t('profile.about.sub'),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AboutPage()),
                  ),
                ),
                _MenuItem(
                  icon: Icons.privacy_tip_outlined,
                  color: const Color(0xFF00C7FF),
                  title: t('profile.privacy'),
                  subtitle: t('profile.privacy.sub'),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PrivacyPage()),
                  ),
                ),
                _MenuItem(
                  icon: Icons.description_outlined,
                  color: const Color(0xFFFF9500),
                  title: t('profile.terms'),
                  subtitle: t('profile.terms.sub'),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const TermsPage()),
                  ),
                ),
                const SizedBox(height: 24),
                _LogoutButton(
                  label: t('profile.logout'),
                  confirmLabel: t('profile.logout.confirm'),
                  cancelLabel: t('common.cancel'),
                  onConfirm: () {
                    ref.read(authProvider.notifier).logout();
                    context.go('/login');
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    AppToast.show(
      context,
      title: settings.isArabic ? 'قريباً' : 'Coming soon',
      message: settings.isArabic
          ? 'هذه الخاصية تحت التطوير وسنطلقها قريباً'
          : 'This feature is under development and will be released soon',
      kind: AppToastKind.info,
      duration: const Duration(seconds: 2),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    showBlurredDialog(
      context: context,
      builder: (ctx) {
        final p = c(ctx);
        return Dialog(
          backgroundColor: p.bgTop,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: p.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.language_rounded,
                        color: p.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.get('lang.title', settings.locale),
                      style: TextStyle(
                        color: p.text,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _LangChoice(
                  flag: '🇸🇦',
                  label: AppStrings.get('lang.ar', settings.locale),
                  code: 'AR',
                  selected: settings.locale == AppLocale.ar,
                  onTap: () {
                    ref.read(settingsProvider.notifier).setLocale(AppLocale.ar);
                    Navigator.of(ctx).pop();
                  },
                ),
                const SizedBox(height: 10),
                _LangChoice(
                  flag: '🇬🇧',
                  label: AppStrings.get('lang.en', settings.locale),
                  code: 'EN',
                  selected: settings.locale == AppLocale.en,
                  onTap: () {
                    ref.read(settingsProvider.notifier).setLocale(AppLocale.en);
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    showBlurredDialog(
      context: context,
      builder: (ctx) {
        final p = c(ctx);
        return Dialog(
          backgroundColor: p.bgTop,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: p.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.palette_rounded,
                        color: p.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.get('theme.title', settings.locale),
                      style: TextStyle(
                        color: p.text,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _ThemeChoice(
                  icon: Icons.dark_mode_rounded,
                  color: const Color(0xFF7B6BFF),
                  label: AppStrings.get('theme.dark', settings.locale),
                  selected: settings.isDark,
                  onTap: () {
                    ref
                        .read(settingsProvider.notifier)
                        .setThemeMode(AppThemeMode.dark);
                    Navigator.of(ctx).pop();
                  },
                ),
                const SizedBox(height: 10),
                _ThemeChoice(
                  icon: Icons.light_mode_rounded,
                  color: const Color(0xFFFF9500),
                  label: AppStrings.get('theme.light', settings.locale),
                  selected: !settings.isDark,
                  onTap: () {
                    ref
                        .read(settingsProvider.notifier)
                        .setThemeMode(AppThemeMode.light);
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final p = c(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            p.bgTop,
            p.background,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 14),
            Stack(
              children: [
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, Color(0xFF7B6BFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: p.primary.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: p.background,
                        width: 2.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'admin@company.com',
              style: TextStyle(
                color: p.text,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: p.primary.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: p.primary.withValues(alpha: 0.35),
                ),
              ),
              child: Text(
                AppStrings.get('profile.role', settings.locale),
                style: TextStyle(
                  color: p.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 4, left: 4),
      child: Text(
        text,
        style: TextStyle(
          color: p.primary,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _MenuItem extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String? trailingBadge;
  final Widget? trailing;

  const _MenuItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailingBadge,
    this.trailing,
  });

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: p.card,
            border: Border.all(color: p.border),
            borderRadius: BorderRadius.circular(14),
            boxShadow: p.isDark
                ? null
                : [
                    BoxShadow(
                      color: p.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: widget.color.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(widget.icon, color: widget.color, size: 20),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: p.text,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: p.mutedText,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null)
                widget.trailing!
              else if (widget.trailingBadge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: p.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: p.primary.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    widget.trailingBadge!,
                    style: TextStyle(
                      color: p.primary,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              else
                Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Icons.chevron_left_rounded
                      : Icons.chevron_right_rounded,
                  color: p.mutedText,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LangChoice extends StatelessWidget {
  final String flag;
  final String label;
  final String code;
  final bool selected;
  final VoidCallback onTap;

  const _LangChoice({
    required this.flag,
    required this.label,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? p.primary.withValues(alpha: 0.15)
              : p.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? p.primary : p.border,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: p.text,
                  fontSize: 14.5,
                  fontWeight:
                      selected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: selected
                    ? p.primary
                    : p.border,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                code,
                style: TextStyle(
                  color: selected ? Colors.white : p.mutedText,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? p.primary : p.mutedText,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeChoice extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeChoice({
    required this.icon,
    required this.color,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.18)
              : p.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : p.border,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: p.text,
                  fontSize: 14.5,
                  fontWeight:
                      selected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? color : p.mutedText,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final String label;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;

  const _LogoutButton({
    required this.label,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showBlurredDialog(
          context: context,
          builder: (ctx) {
            final pp = c(ctx);
            return AlertDialog(
              backgroundColor: pp.bgTop,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                label,
                style: TextStyle(
                  color: pp.text,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Text(
                confirmLabel,
                style: TextStyle(color: pp.mutedText),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(cancelLabel,
                      style: TextStyle(color: pp.mutedText)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    onConfirm();
                  },
                  child: Text(label,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: p.isDark ? 0.12 : 0.08),
          border: Border.all(
            color: Colors.redAccent.withValues(alpha: 0.4),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded,
                color: Colors.redAccent, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
