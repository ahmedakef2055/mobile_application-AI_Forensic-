import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class IncidentDetailPage extends StatefulWidget {
  const IncidentDetailPage({super.key});
  static const routePath = '/incident-detail';

  @override
  State<IncidentDetailPage> createState() => _IncidentDetailPageState();
}

class _IncidentDetailPageState extends State<IncidentDetailPage> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_p.bgTop, _p.bgBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _TopBar(
                title: 'Incident Detail',
                subtitle: 'Security incident analysis',
                onBack: () => Navigator.pop(context),
                onShare: () {},
              ),
              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _IncidentHeroCard(
                        severity: _Severity.critical,
                        title: 'Brute Force Attack',
                        description:
                            'Active security threat detected and contained',
                        code: 'INC-01234',
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: const [
                          Expanded(
                            child: _InfoTile(
                              icon: Icons.access_time_rounded,
                              label: 'Time',
                              value: '10:24 - 10:31',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _InfoTile(
                              icon: Icons.person_outline_rounded,
                              label: 'Source',
                              value: 'user@example.com',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _InfoTile(
                              icon: Icons.my_location_rounded,
                              label: 'Target',
                              value: 'DB-Server-01',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      _Tabs(
                        index: tabIndex,
                        onChanged: (i) => setState(() => tabIndex = i),
                      ),

                      const SizedBox(height: 12),

                      if (tabIndex == 0) ...[
                        const _SectionTitle(
                          icon: Icons.event_note_rounded,
                          title: 'Event Timeline',
                        ),
                        const SizedBox(height: 10),
                        _TimelineItem(
                          time: '10:24',
                          text:
                              'Initial brute force attempt detected',
                        ),
                        const SizedBox(height: 8),
                        _TimelineItem(
                          time: '10:26',
                          text:
                              'Multiple failed authentication attempts logged',
                        ),
                        const SizedBox(height: 8),
                        _TimelineItem(
                          time: '10:28',
                          text:
                              'Alert generated and sent to security team',
                        ),
                      ] else if (tabIndex == 1) ...[
                        const _SectionTitle(
                          icon: Icons.info_outline_rounded,
                          title: 'Details',
                        ),
                        const SizedBox(height: 10),
                        _DetailBox(
                          title: 'Incident Summary',
                          body:
                              'A brute force pattern was detected against the authentication endpoint. The system throttled requests and blocked the attacker IP after repeated failures.',
                        ),
                        const SizedBox(height: 10),
                        _DetailBox(
                          title: 'Recommendation',
                          body:
                              'Review account access logs, enforce MFA for privileged users, and ensure rate limiting is enabled across gateways.',
                        ),
                      ] else ...[
                        const _SectionTitle(
                          icon: Icons.bolt_rounded,
                          title: 'Actions',
                        ),
                        const SizedBox(height: 10),
                        _ActionRow(
                          icon: Icons.shield_outlined,
                          title: 'Add rule to firewall',
                          subtitle: 'Block source IP permanently',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),
                        _ActionRow(
                          icon: Icons.lock_reset_rounded,
                          title: 'Force password reset',
                          subtitle: 'Reset affected account credentials',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),
                        _ActionRow(
                          icon: Icons.download_rounded,
                          title: 'Export incident logs',
                          subtitle: 'Download full timeline report',
                          onTap: () {},
                        ),
                      ],

                      const SizedBox(height: 18),

                      _PrimaryButton(
                        text: 'Block Attacker',
                        style: _PrimaryStyle.danger,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                      _PrimaryButton(
                        text: 'View Full Report on Web',
                        style: _PrimaryStyle.dark,
                        onPressed: () {},
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

/* ------------------ Top Bar ------------------ */

class _TopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final VoidCallback onShare;

  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: _p.text),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _p.text,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _p.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onShare,
            icon: Icon(Icons.ios_share_rounded,
                color: _p.text, size: 20),
          ),
        ],
      ),
    );
  }
}

/* ------------------ Hero Card ------------------ */

class _IncidentHeroCard extends StatelessWidget {
  final _Severity severity;
  final String title;
  final String description;
  final String code;

  const _IncidentHeroCard({
    required this.severity,
    required this.title,
    required this.description,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _p.border),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: severity.heroGradient,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: const Color(0x14000000),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _p.border),
                ),
                child: Icon(severity.icon, size: 16, color: severity.accent),
              ),
              const SizedBox(width: 10),
              _Pill(
                text: severity.label.toUpperCase(),
                bg: severity.pillBg,
                fg: severity.accent,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: _p.text,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: _p.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            code,
            style: TextStyle(
              color: _p.mutedText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;

  const _Pill({required this.text, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11.2,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

/* ------------------ Info tiles ------------------ */

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: _p.mutedText),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: _p.mutedText,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _p.text,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------ Tabs ------------------ */

class _Tabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const _Tabs({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabItem(
              label: 'Timeline',
              selected: index == 0,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _TabItem(
              label: 'Details',
              selected: index == 1,
              onTap: () => onChanged(1),
            ),
          ),
          Expanded(
            child: _TabItem(
              label: 'Actions',
              selected: index == 2,
              onTap: () => onChanged(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: selected ? const Color(0x14000000) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: selected ? Border.all(color: _p.border) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? _p.text : _p.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

/* ------------------ Timeline list ------------------ */

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Row(
      children: [
        Icon(icon, size: 16, color: _p.mutedText),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: _p.text,
            fontSize: 13.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String time;
  final String text;

  const _TimelineItem({
    required this.time,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: const Color(0x14000000),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.border),
            ),
            child: const Icon(Icons.timeline_rounded,
                size: 14, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: _p.mutedText,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    color: _p.text,
                    fontSize: 12.8,
                    fontWeight: FontWeight.w700,
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

/* ------------------ Details boxes ------------------ */

class _DetailBox extends StatelessWidget {
  final String title;
  final String body;

  const _DetailBox({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _p.text,
              fontSize: 12.8,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              color: _p.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------ Actions ------------------ */

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: _p.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _p.border),
        ),
        child: Row(
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: const Color(0x14000000),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _p.border),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _p.text,
                      fontSize: 12.8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: _p.mutedText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: _p.mutedText),
          ],
        ),
      ),
    );
  }
}

/* ------------------ Buttons ------------------ */

enum _PrimaryStyle { danger, dark }

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final _PrimaryStyle style;

  const _PrimaryButton({
    required this.text,
    required this.onPressed,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    final bg = style == _PrimaryStyle.danger
        ? const Color(0xFF5A1F28)
        : const Color(0x14000000);
    final border = style == _PrimaryStyle.danger
        ? const Color(0xFF7A2A35)
        : _p.border;
    final fg = style == _PrimaryStyle.danger
        ? const Color(0xFFFF6B6B)
        : _p.text;

    return SizedBox(
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: border),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

/* ------------------ Severity styling ------------------ */

enum _Severity { critical, high, medium, low }

extension on _Severity {
  String get label {
    switch (this) {
      case _Severity.critical:
        return 'Critical';
      case _Severity.high:
        return 'High';
      case _Severity.medium:
        return 'Medium';
      case _Severity.low:
        return 'Low';
    }
  }

  IconData get icon {
    switch (this) {
      case _Severity.critical:
        return Icons.shield_outlined;
      case _Severity.high:
        return Icons.warning_amber_rounded;
      case _Severity.medium:
        return Icons.report_gmailerrorred_rounded;
      case _Severity.low:
        return Icons.info_outline_rounded;
    }
  }

  Color get accent {
    switch (this) {
      case _Severity.critical:
        return const Color(0xFFFF6B6B);
      case _Severity.high:
        return const Color(0xFFFFA04D);
      case _Severity.medium:
        return const Color(0xFFFFD34D);
      case _Severity.low:
        return const Color(0xFF4ADE80);
    }
  }

  Color get pillBg {
    switch (this) {
      case _Severity.critical:
        return const Color(0x334B1F1F);
      case _Severity.high:
        return const Color(0x334A2F1A);
      case _Severity.medium:
        return const Color(0x334A3E16);
      case _Severity.low:
        return const Color(0x33163D2A);
    }
  }

  List<Color> get heroGradient {
    switch (this) {
      case _Severity.critical:
        return const [Color(0xFF2B1018), Color(0xFF1A0F1A)];
      case _Severity.high:
        return const [Color(0xFF2B1B10), Color(0xFF1A1210)];
      case _Severity.medium:
        return const [Color(0xFF2B2510), Color(0xFF1A1610)];
      case _Severity.low:
        return const [Color(0xFF102B1E), Color(0xFF101A16)];
    }
  }
}