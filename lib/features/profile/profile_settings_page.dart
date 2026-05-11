import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../splash/splash_page.dart';
import '../splash/signing_out_splash_page.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});
  static const routePath = '/profile-settings';

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool critical = true;
  bool high = true;
  bool medium = true;
  bool low = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgTop, AppColors.bgBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _TopBar(
                title: 'Profile & Settings',
                subtitle: 'Manage your preferences',
                onBack: () => Navigator.pop(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _UserCard(),
                      const SizedBox(height: 12),

                      _SectionCard(
                        icon: Icons.notifications_none_rounded,
                        iconBg: const Color(0x1A8B5CF6),
                        iconColor: const Color(0xFFA78BFA),
                        title: 'Notification Settings',
                        child: Column(
                          children: [
                            _NotifRow(
                              dotColor: const Color(0xFFFF6B6B),
                              label: 'Critical - Push & Sound',
                              value: critical,
                              onChanged: (v) => setState(() => critical = v),
                            ),
                            const SizedBox(height: 10),
                            _NotifRow(
                              dotColor: const Color(0xFFFFA04D),
                              label: 'High - Push',
                              value: high,
                              onChanged: (v) => setState(() => high = v),
                            ),
                            const SizedBox(height: 10),
                            _NotifRow(
                              dotColor: const Color(0xFFFFD34D),
                              label: 'Medium - Silent',
                              value: medium,
                              onChanged: (v) => setState(() => medium = v),
                            ),
                            const SizedBox(height: 10),
                            _NotifRow(
                              dotColor: const Color(0xFF4ADE80),
                              label: 'Low - Email only',
                              value: low,
                              onChanged: (v) => setState(() => low = v),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      _ActionTile(
                        icon: Icons.public_rounded,
                        iconColor: const Color(0xFFFFA04D),
                        iconBg: const Color(0x1AFFA04D),
                        title: 'Time Zone & Date/Time Range',
                        subtitle: 'Configure regional settings',
                        onTap: () {},
                      ),

                      const SizedBox(height: 10),

                      _ActionTile(
                        icon: Icons.verified_user_outlined,
                        iconColor: const Color(0xFF4ADE80),
                        iconBg: const Color(0x1A4ADE80),
                        title: 'Security Preferences',
                        subtitle: '',
                        onTap: () {},
                      ),

                      const SizedBox(height: 14),

                      _SignOutButton(
                        onTap: () {
                           context.go(SigningOutSplashPage.routePath);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- Top Bar ---------------- */

class _TopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- User Card ---------------- */

class _UserCard extends StatelessWidget {
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF123A74), Color(0xFF0E1D34)],
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0x14000000),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.person_outline_rounded,
                color: Color(0xFF93C5FD)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Admin User',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'admin@company.com',
                  style: TextStyle(
                    color: Color(0xFFB6C2D6),
                    fontSize: 12.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                _RolePill(),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.mutedText),
        ],
      ),
    );
  }
}

class _RolePill extends StatelessWidget {
  const _RolePill();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0x1A60A5FA),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0x3360A5FA)),
        ),
        child: const Text(
          'Administrator',
          style: TextStyle(
            color: Color(0xFF93C5FD),
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

/* ---------------- Section Card ---------------- */

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

/* ---------------- Notif Row ---------------- */

class _NotifRow extends StatelessWidget {
  final Color dotColor;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotifRow({
    required this.dotColor,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 12.6,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF60A5FA),
          inactiveThumbColor: const Color(0xFF94A3B8),
          inactiveTrackColor: const Color(0xFF1F2A44),
        ),
      ],
    );
  }
}

/* ---------------- Action Tile ---------------- */

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 11.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.mutedText),
          ],
        ),
      ),
    );
  }
}

/* ---------------- Sign Out ---------------- */

class _SignOutButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SignOutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0x334B1F1F)),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2B1018), Color(0xFF15101A)],
          ),
        ),
        child: const Center(
          child: Text(
            'Sign Out',
            style: TextStyle(
              color: Color(0xFFFF6B6B),
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}