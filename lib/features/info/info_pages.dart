import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../providers/settings_provider.dart';

class _InfoScaffold extends ConsumerWidget {
  final String title;
  final IconData heroIcon;
  final Color heroColor;
  final List<Widget> children;

  const _InfoScaffold({
    required this.title,
    required this.heroIcon,
    required this.heroColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = c(context);
    return Scaffold(
      backgroundColor: p.background,
      appBar: AppBarWidget(
        title: title,
        subtitle: 'معلومات مهمة عن التطبيق',
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate(children),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoSectionCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  const InfoSectionCard({
    super.key,
    required this.title,
    required this.body,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: p.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: p.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: p.text,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: TextStyle(
              color: p.mutedText,
              fontSize: 13.5,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== About Page =====================
class AboutPage extends ConsumerWidget {
  static const routePath = '/about';
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = c(context);
    String t(String k) => ref.tr(k);

    return _InfoScaffold(
      title: t('about.title'),
      heroIcon: Icons.info_rounded,
      heroColor: p.primary,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                p.primary.withValues(alpha: 0.20),
                p.primary.withValues(alpha: 0.05),
              ],
            ),
            border: Border.all(
              color: p.primary.withValues(alpha: 0.30),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: p.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: p.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                t('about.app_name'),
                style: TextStyle(
                  color: p.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                t('about.tagline'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: p.mutedText,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _MetaRow(
          icon: Icons.tag_rounded,
          label: t('about.version'),
          value: '1.0.0',
        ),
        _MetaRow(
          icon: Icons.code_rounded,
          label: t('about.build'),
          value: '#2026.05.11',
        ),
        _MetaRow(
          icon: Icons.business_rounded,
          label: t('about.developer'),
          value: 'AI Forensic Team',
        ),
        _MetaRow(
          icon: Icons.gavel_rounded,
          label: t('about.license'),
          value: 'Proprietary',
        ),
        const SizedBox(height: 16),
        Text(
          t('about.features'),
          style: TextStyle(
            color: p.primary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        _FeatureRow(icon: Icons.smart_toy_rounded, text: t('about.feat1')),
        _FeatureRow(icon: Icons.search_rounded, text: t('about.feat2')),
        _FeatureRow(icon: Icons.bolt_rounded, text: t('about.feat3')),
        _FeatureRow(
            icon: Icons.notifications_active_rounded, text: t('about.feat4')),
        const SizedBox(height: 20),
        Center(
          child: Text(
            t('about.copyright'),
            style: TextStyle(
              color: p.mutedText,
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetaRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: p.primary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: p.text,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: p.mutedText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: p.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: p.primary, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: p.text,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== Help Page =====================
class HelpPage extends ConsumerStatefulWidget {
  static const routePath = '/help';
  const HelpPage({super.key});

  @override
  ConsumerState<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends ConsumerState<HelpPage> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    String t(String k) => ref.tr(k);
    final faqs = [
      {'q': t('help.q1'), 'a': t('help.a1')},
      {'q': t('help.q2'), 'a': t('help.a2')},
      {'q': t('help.q3'), 'a': t('help.a3')},
      {'q': t('help.q4'), 'a': t('help.a4')},
      {'q': t('help.q5'), 'a': t('help.a5')},
    ];

    return _InfoScaffold(
      title: t('help.title'),
      heroIcon: Icons.help_rounded,
      heroColor: const Color(0xFF34C759),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: p.card,
            border: Border.all(color: p.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: Color(0xFF34C759),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  t('help.intro'),
                  style: TextStyle(
                    color: p.text,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                p.primary.withValues(alpha: 0.18),
                p.primary.withValues(alpha: 0.06),
              ],
            ),
            border: Border.all(
              color: p.primary.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(Icons.mail_outline_rounded,
                  color: p.primary, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t('help.contact_us'),
                      style: TextStyle(
                        color: p.text,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t('help.email'),
                      style: TextStyle(
                        color: p.primary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            t('help.faq'),
            style: TextStyle(
              color: p.primary,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(faqs.length, (i) {
          final isOpen = _expandedIndex == i;
          return _FaqTile(
            question: faqs[i]['q']!,
            answer: faqs[i]['a']!,
            isOpen: isOpen,
            onTap: () {
              setState(() {
                _expandedIndex = isOpen ? null : i;
              });
            },
          );
        }),
      ],
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;
  final bool isOpen;
  final VoidCallback onTap;

  const _FaqTile({
    required this.question,
    required this.answer,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(
          color: isOpen
              ? p.primary.withValues(alpha: 0.5)
              : p.border,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: p.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: p.primary,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        color: p.text,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isOpen ? 0.5 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: p.mutedText,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: p.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: p.border),
                ),
                child: Text(
                  answer,
                  style: TextStyle(
                    color: p.mutedText,
                    fontSize: 12.5,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== Privacy Page =====================
class PrivacyPage extends ConsumerWidget {
  static const routePath = '/privacy';
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = c(context);
    String t(String k) => ref.tr(k);
    return _InfoScaffold(
      title: t('privacy.title'),
      heroIcon: Icons.privacy_tip_rounded,
      heroColor: const Color(0xFF0098C7),
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: p.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: p.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.update_rounded,
                  color: p.primary, size: 16),
              const SizedBox(width: 8),
              Text(
                t('privacy.last_updated'),
                style: TextStyle(
                  color: p.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        InfoSectionCard(
          icon: Icons.data_usage_rounded,
          title: t('privacy.s1.title'),
          body: t('privacy.s1.body'),
        ),
        InfoSectionCard(
          icon: Icons.analytics_rounded,
          title: t('privacy.s2.title'),
          body: t('privacy.s2.body'),
        ),
        InfoSectionCard(
          icon: Icons.security_rounded,
          title: t('privacy.s3.title'),
          body: t('privacy.s3.body'),
        ),
        InfoSectionCard(
          icon: Icons.verified_user_rounded,
          title: t('privacy.s4.title'),
          body: t('privacy.s4.body'),
        ),
        InfoSectionCard(
          icon: Icons.cookie_outlined,
          title: t('privacy.s5.title'),
          body: t('privacy.s5.body'),
        ),
      ],
    );
  }
}

// ===================== Terms Page =====================
class TermsPage extends ConsumerWidget {
  static const routePath = '/terms';
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = c(context);
    String t(String k) => ref.tr(k);
    return _InfoScaffold(
      title: t('terms.title'),
      heroIcon: Icons.description_rounded,
      heroColor: const Color(0xFFFF9500),
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFF9500).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFF9500).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline_rounded,
                  color: Color(0xFFFF9500), size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  t('terms.intro'),
                  style: TextStyle(
                    color: p.text,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        InfoSectionCard(
          icon: Icons.handshake_rounded,
          title: t('terms.s1.title'),
          body: t('terms.s1.body'),
        ),
        InfoSectionCard(
          icon: Icons.check_circle_outline_rounded,
          title: t('terms.s2.title'),
          body: t('terms.s2.body'),
        ),
        InfoSectionCard(
          icon: Icons.person_outline_rounded,
          title: t('terms.s3.title'),
          body: t('terms.s3.body'),
        ),
        InfoSectionCard(
          icon: Icons.copyright_rounded,
          title: t('terms.s4.title'),
          body: t('terms.s4.body'),
        ),
        InfoSectionCard(
          icon: Icons.warning_amber_rounded,
          title: t('terms.s5.title'),
          body: t('terms.s5.body'),
        ),
        InfoSectionCard(
          icon: Icons.edit_note_rounded,
          title: t('terms.s6.title'),
          body: t('terms.s6.body'),
        ),
      ],
    );
  }
}
