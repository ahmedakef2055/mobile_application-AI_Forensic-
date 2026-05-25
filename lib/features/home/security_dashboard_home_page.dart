import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../alerts/security_alerts_page.dart';
import '../notifications/notifications_page.dart';
import '../profile/profile_settings_page.dart';

class SecurityDashboardHomePage extends StatelessWidget {
  const SecurityDashboardHomePage({super.key});
  static const routePath = '/dashboard-home';

  @override
  Widget build(BuildContext context) {
    void goToAlerts() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SecurityAlertsPage()),
      );
    }

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
                title: 'Security Dashboard',
                subtitle: 'Real-time monitoring & analytics',
                onBack: () => Navigator.pop(context),
                onBell: () => context.go(NotificationsPage.routePath),
                onSettings: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) => const ProfileSettingsPage(),
                 ),
             );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _WelcomeHeader(),
                      const SizedBox(height: 14),

                      // ✅ أي كارد يفتح Alerts Dashboard
                      _StatsCardAlerts(onTap: goToAlerts),
                      const SizedBox(height: 12),
                      _StatsCardTopTarget(onTap: goToAlerts),
                      const SizedBox(height: 12),
                      _StatsCardCriticalIncidents(onTap: goToAlerts),
                      const SizedBox(height: 12),
                      _StatsCardSecurityScore(onTap: goToAlerts),
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
  final VoidCallback onBell;
  final VoidCallback onSettings;

  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
    required this.onBell,
    required this.onSettings,
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
          const SizedBox(width: 4),
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: AppColors.primary,
              size: 18,
            ),
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
          Stack(
            children: [
              IconButton(
                onPressed: onBell,
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.text,
                ),
              ),
              Positioned(
                right: 12,
                top: 10,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onSettings,
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- Welcome Header ---------------- */

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Welcome back 👋',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Here's what's happening with your security today",
          style: TextStyle(
            color: AppColors.mutedText,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/* ---------------- Clickable Base Card (FIXED OVERFLOW) ---------------- */

class _BaseStatCard extends StatelessWidget {
  final List<Color> gradient;
  final Widget child;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _BaseStatCard({
    required this.gradient,
    required this.child,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        // ✅ بدل height ثابت -> minHeight عشان يتمدد لو المحتوى زاد
        constraints: const BoxConstraints(minHeight: 112),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: const Color(0x14000000),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(child: child),
            const Icon(Icons.chevron_right_rounded, color: AppColors.mutedText),
          ],
        ),
      ),
    );
  }
}

/* ---------------- Card 1 ---------------- */

class _StatsCardAlerts extends StatelessWidget {
  final VoidCallback onTap;
  const _StatsCardAlerts({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _BaseStatCard(
      onTap: onTap,
      icon: Icons.notifications_none_rounded,
      iconColor: const Color(0xFF60A5FA),
      gradient: const [Color(0xFF122B4D), Color(0xFF0E1D34)],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Total Alerts Today',
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '24',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          // ✅ Wrap بدل Row
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              Icon(Icons.trending_up_rounded,
                  size: 14, color: Color(0xFF4ADE80)),
              Text(
                '+12% from yesterday',
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ---------------- Card 2 ---------------- */

class _StatsCardTopTarget extends StatelessWidget {
  final VoidCallback onTap;
  const _StatsCardTopTarget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _BaseStatCard(
      onTap: onTap,
      icon: Icons.my_location_rounded,
      iconColor: const Color(0xFFFFB020),
      gradient: const [Color(0xFF3A2A23), Color(0xFF1A1412)],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Top Target Asset',
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'DB-Server-01',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          // ✅ Wrap بدل Row
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              Icon(Icons.block_rounded,
                  size: 14, color: Color(0xFFFFA04D)),
              Text(
                '18 attacks blocked',
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ---------------- Card 3 ---------------- */

class _StatsCardCriticalIncidents extends StatelessWidget {
  final VoidCallback onTap;
  const _StatsCardCriticalIncidents({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _BaseStatCard(
      onTap: onTap,
      icon: Icons.warning_amber_rounded,
      iconColor: const Color(0xFFFF6B6B),
      gradient: const [Color(0xFF2B1018), Color(0xFF15101A)],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Critical Incidents',
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '3',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 6),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Open',
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          // ✅ Wrap بدل Row
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              Icon(Icons.priority_high_rounded,
                  size: 14, color: Color(0xFFFF6B6B)),
              Text(
                'Requires immediate attention',
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ---------------- Card 4 ---------------- */

class _StatsCardSecurityScore extends StatelessWidget {
  final VoidCallback onTap;
  const _StatsCardSecurityScore({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _BaseStatCard(
      onTap: onTap,
      icon: Icons.verified_user_outlined,
      iconColor: const Color(0xFF4ADE80),
      gradient: const [Color(0xFF0F2B22), Color(0xFF0E1A16)],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Overall Security Score',
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 12.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '87',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '/100',
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          // ✅ Wrap بدل Row
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            runSpacing: 4,
            children: [
              Icon(Icons.check_circle_rounded,
                  size: 14, color: Color(0xFF4ADE80)),
              Text(
                'Good - Stable',
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}