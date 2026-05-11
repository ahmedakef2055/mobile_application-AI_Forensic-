import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_toast.dart';
import '../../core/widgets/blurred_dialog.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../providers/settings_provider.dart';
import '../info/info_pages.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const routePath = '/settings';

  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool notifications = true;
  bool emailAlerts = true;
  bool smsAlerts = false;
  bool biometricLogin = false;
  bool twoFactor = false;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final settings = ref.watch(settingsProvider);
    String t(String k) => AppStrings.get(k, settings.locale);

    return Scaffold(
      backgroundColor: p.background,
      appBar: AppBarWidget(
        title: t('settings.title'),
        subtitle: 'إدارة إعدادات التطبيق والحسابات',
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Section(
                    title: t('settings.section.language'),
                    icon: Icons.public_rounded,
                    children: [
                      _Tile(
                        icon: Icons.language_rounded,
                        title: t('settings.app_language'),
                        subtitle: settings.isArabic
                            ? AppStrings.get('lang.ar', settings.locale)
                            : AppStrings.get('lang.en', settings.locale),
                        onTap: () => _showLanguageDialog(settings),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            settings.isArabic ? 'AR' : 'EN',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _Section(
                    title: t('settings.section.notifications'),
                    icon: Icons.notifications_rounded,
                    children: [
                      _SwitchTile(
                        icon: Icons.notifications_active_outlined,
                        title: t('settings.notifications.enable'),
                        subtitle: t('settings.notifications.enable.sub'),
                        value: notifications,
                        onChanged: (v) => setState(() => notifications = v),
                      ),
                      _SwitchTile(
                        icon: Icons.mail_outline_rounded,
                        title: t('settings.notifications.email'),
                        subtitle: t('settings.notifications.email.sub'),
                        value: emailAlerts,
                        onChanged: (v) => setState(() => emailAlerts = v),
                      ),
                      _SwitchTile(
                        icon: Icons.sms_outlined,
                        title: t('settings.notifications.sms'),
                        subtitle: t('settings.notifications.sms.sub'),
                        value: smsAlerts,
                        onChanged: (v) => setState(() => smsAlerts = v),
                      ),
                    ],
                  ),
                  _Section(
                    title: t('settings.section.security'),
                    icon: Icons.security_rounded,
                    children: [
                      _SwitchTile(
                        icon: Icons.fingerprint_rounded,
                        title: t('settings.biometric'),
                        subtitle: t('settings.biometric.sub'),
                        value: biometricLogin,
                        onChanged: (v) =>
                            setState(() => biometricLogin = v),
                      ),
                      _SwitchTile(
                        icon: Icons.shield_outlined,
                        title: t('settings.2fa'),
                        subtitle: t('settings.2fa.sub'),
                        value: twoFactor,
                        onChanged: (v) => setState(() => twoFactor = v),
                      ),
                      _Tile(
                        icon: Icons.vpn_key_outlined,
                        title: t('settings.change_password'),
                        subtitle: t('settings.change_password.sub'),
                        onTap: () {
                          AppToast.show(
                            context,
                            title: t('toast.coming_soon'),
                            message: t('settings.change_password.toast'),
                            kind: AppToastKind.info,
                          );
                        },
                        trailing: _arrow(p, settings.isArabic),
                      ),
                    ],
                  ),
                  _Section(
                    title: t('settings.section.about'),
                    icon: Icons.info_rounded,
                    children: [
                      _Tile(
                        icon: Icons.info_outline_rounded,
                        title: t('settings.version'),
                        subtitle: t('settings.version.sub'),
                        trailing: Text(
                          'v1.0.0',
                          style: TextStyle(
                            color: p.mutedText,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      _Tile(
                        icon: Icons.privacy_tip_outlined,
                        title: t('profile.privacy'),
                        subtitle: t('profile.privacy.sub'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const PrivacyPage()),
                        ),
                        trailing: _arrow(p, settings.isArabic),
                      ),
                      _Tile(
                        icon: Icons.description_outlined,
                        title: t('profile.terms'),
                        subtitle: t('profile.terms.sub'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const TermsPage()),
                        ),
                        trailing: _arrow(p, settings.isArabic),
                      ),
                      _Tile(
                        icon: Icons.info_rounded,
                        title: t('profile.about'),
                        subtitle: t('profile.about.sub'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const AboutPage()),
                        ),
                        trailing: _arrow(p, settings.isArabic),
                      ),
                      _Tile(
                        icon: Icons.help_outline_rounded,
                        title: t('profile.help'),
                        subtitle: t('profile.help.sub'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const HelpPage()),
                        ),
                        trailing: _arrow(p, settings.isArabic),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSignOutButton(p, t),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrow(AppPalette p, bool isArabic) => Icon(
        isArabic
            ? Icons.chevron_left_rounded
            : Icons.chevron_right_rounded,
        color: p.mutedText,
        size: 22,
      );

  Widget _buildSliverAppBar(AppPalette p, String Function(String) t) {
    return SliverAppBar(
      expandedHeight: 130,
      pinned: true,
      backgroundColor: p.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [p.bgTop, p.background],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          t('settings.title'),
                          style: TextStyle(
                            color: p.text,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          t('settings.subtitle'),
                          style: TextStyle(
                            color: p.mutedText,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutButton(AppPalette p, String Function(String) t) {
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
              title: Text(t('settings.signout'),
                  style: TextStyle(
                    color: pp.text,
                    fontWeight: FontWeight.w800,
                  )),
              content: Text(t('settings.signout.confirm'),
                  style: TextStyle(color: pp.mutedText)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(t('common.cancel'),
                      style: TextStyle(color: pp.mutedText)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(t('settings.signout.action'),
                      style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w800)),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.1),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded,
                color: Colors.redAccent, size: 20),
            const SizedBox(width: 10),
            Text(
              t('settings.signout'),
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

  void _showLanguageDialog(AppSettings settings) {
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
            AppStrings.get('lang.title', settings.locale),
            style: TextStyle(color: pp.text, fontWeight: FontWeight.w800),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _langOption(
                pp,
                AppStrings.get('lang.ar', settings.locale),
                'AR',
                settings.locale == AppLocale.ar,
                () {
                  ref
                      .read(settingsProvider.notifier)
                      .setLocale(AppLocale.ar);
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: 8),
              _langOption(
                pp,
                AppStrings.get('lang.en', settings.locale),
                'EN',
                settings.locale == AppLocale.en,
                () {
                  ref
                      .read(settingsProvider.notifier)
                      .setLocale(AppLocale.en);
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _langOption(
    AppPalette pp,
    String label,
    String code,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          border: Border.all(
            color: selected ? AppColors.primary : pp.border,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? AppColors.primary : pp.mutedText,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: pp.text,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : pp.border,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                code,
                style: TextStyle(
                  color: selected ? Colors.white : pp.mutedText,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _Section({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4, bottom: 10, left: 4),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: p.card,
              border: Border.all(color: p.border),
              borderRadius: BorderRadius.circular(16),
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
            child: Column(
              children: [
                for (int i = 0; i < children.length; i++) ...[
                  children[i],
                  if (i != children.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: p.border,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: widget.onTap == null
          ? null
          : (_) => setState(() => _pressed = true),
      onTapUp: widget.onTap == null
          ? null
          : (_) => setState(() => _pressed = false),
      onTapCancel:
          widget.onTap == null ? null : () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.primary,
                  size: 19,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: p.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: p.mutedText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null) ...[
                const SizedBox(width: 8),
                widget.trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return _Tile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: () => onChanged(!value),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
        inactiveThumbColor: p.mutedText,
        inactiveTrackColor: p.border,
      ),
    );
  }
}
