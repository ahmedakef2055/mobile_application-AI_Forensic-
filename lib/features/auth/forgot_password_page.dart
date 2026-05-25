import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});
  static const routePath = '/forgot-password';

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final emailCtrl = TextEditingController();
  bool _isLoading = false;
  bool _sent = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    final email = emailCtrl.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    final ok = await ref.read(authProvider.notifier).resetPassword(email);
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _sent = ok;
    });

    if (!ok) {
      final err = ref.read(authProvider).error ?? 'Failed to send reset link';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

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
            colors: _p.isDark ? [_p.bgTop, _p.bgBottom] : [_p.bgTop, _p.background],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    _LogoHeader(sent: _sent),
                    const SizedBox(height: 26),
                    if (_sent)
                      _SuccessCard(
                        email: emailCtrl.text.trim(),
                        onBack: () => Navigator.pop(context),
                      )
                    else
                      _ForgotCard(
                        emailCtrl: emailCtrl,
                        isLoading: _isLoading,
                        onBack: () => Navigator.pop(context),
                        onSend: _handleSend,
                      ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoHeader extends StatelessWidget {
  final bool sent;
  const _LogoHeader({this.sent = false});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Column(
      children: [
        Container(
          height: 92,
          width: 92,
          decoration: BoxDecoration(
            color: _p.card,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: _p.border),
            boxShadow: [
              BoxShadow(
                blurRadius: 26,
                spreadRadius: 2,
                color: _p.isDark
                    ? const Color(0x22000000)
                    : AppColors.primary.withValues(alpha: 0.15),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          sent ? 'Check Your Email' : 'Forgot Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _p.text,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          sent
              ? 'We\'ve sent a reset link to your inbox'
              : 'Enter your email and we\'ll send you a reset link',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _p.mutedText,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _SuccessCard extends StatelessWidget {
  final String email;
  final VoidCallback onBack;
  const _SuccessCard({required this.email, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF4ADE80).withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF4ADE80).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mark_email_read_rounded,
                color: Color(0xFF4ADE80), size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            'Reset link sent to:',
            style: TextStyle(color: _p.mutedText, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(
              color: _p.text,
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Back to Sign in',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ForgotCard extends StatelessWidget {
  final TextEditingController emailCtrl;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onSend;

  const _ForgotCard({
    required this.emailCtrl,
    required this.isLoading,
    required this.onBack,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Email Address',
            style: TextStyle(
              color: _p.text,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _Input(
            controller: emailCtrl,
            hint: 'example@company.com',
            prefix: Icon(Icons.mail_outline, size: 18, color: _p.mutedText),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSend,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Send Reset Link',
                      style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: InkWell(
              onTap: onBack,
              borderRadius: BorderRadius.circular(10),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(
                  'Back to Sign in',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12.8,
                    fontWeight: FontWeight.w800,
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

class _Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefix;
  final TextInputType? keyboardType;

  const _Input({
    required this.controller,
    required this.hint,
    this.prefix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: _p.text, fontSize: 14.5),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _p.mutedText, fontSize: 13.5),
        prefixIcon: prefix,
        filled: true,
        fillColor: _p.isDark ? const Color(0x14000000) : _p.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _p.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _p.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
