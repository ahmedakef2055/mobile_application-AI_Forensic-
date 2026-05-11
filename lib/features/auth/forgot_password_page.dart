import 'package:flutter/material.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  static const routePath = '/forgot-password';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
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
                    _LogoHeader(),
                    const SizedBox(height: 26),
                    _ForgotCard(
                      emailCtrl: emailCtrl,
                      onBack: () => Navigator.pop(context),
                      onSend: () {},
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
          'Forgot Password',
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
          'Enter your email and we’ll send you a reset link',
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

class _ForgotCard extends StatelessWidget {
  final TextEditingController emailCtrl;
  final VoidCallback onBack;
  final VoidCallback onSend;

  const _ForgotCard({
    required this.emailCtrl,
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
            prefix: Icon(Icons.mail_outline,
                size: 18, color: _p.mutedText),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),

          _PrimaryButton(
            text: 'Send Reset Link',
            onPressed: onSend,
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
  final Widget? suffix;
  final TextInputType? keyboardType;
  final bool obscure;

  const _Input({
    required this.controller,
    required this.hint,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: TextStyle(color: _p.text, fontSize: 14.5),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _p.mutedText, fontSize: 13.5),
        prefixIcon: prefix,
        suffixIcon: suffix,
        filled: true,
        fillColor: _p.isDark ? const Color(0x14000000) : _p.background,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _PrimaryButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return SizedBox(
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}