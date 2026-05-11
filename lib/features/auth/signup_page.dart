import 'package:flutter/material.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static const routePath = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool agree = false;
  bool obscure1 = true;
  bool obscure2 = true;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
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
                    _SignupCard(
                      agree: agree,
                      obscure1: obscure1,
                      obscure2: obscure2,
                      nameCtrl: nameCtrl,
                      emailCtrl: emailCtrl,
                      passCtrl: passCtrl,
                      confirmCtrl: confirmCtrl,
                      onToggleAgree: (v) => setState(() => agree = v),
                      onToggleObscure1: () =>
                          setState(() => obscure1 = !obscure1),
                      onToggleObscure2: () =>
                          setState(() => obscure2 = !obscure2),
                      onGoLogin: () => Navigator.pop(context),
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
          'Create Account',
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
          'Sign up to create your security dashboard account',
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

class _SignupCard extends StatelessWidget {
  final bool agree;
  final bool obscure1;
  final bool obscure2;

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final TextEditingController confirmCtrl;

  final ValueChanged<bool> onToggleAgree;
  final VoidCallback onToggleObscure1;
  final VoidCallback onToggleObscure2;
  final VoidCallback onGoLogin;

  const _SignupCard({
    required this.agree,
    required this.obscure1,
    required this.obscure2,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
    required this.confirmCtrl,
    required this.onToggleAgree,
    required this.onToggleObscure1,
    required this.onToggleObscure2,
    required this.onGoLogin,
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
            'Full Name',
            style: TextStyle(
              color: _p.text,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _Input(
            controller: nameCtrl,
            hint: 'Enter your full name',
            prefix: Icon(Icons.person_outline,
                size: 18, color: _p.mutedText),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 14),

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

          Text(
            'Password',
            style: TextStyle(
              color: _p.text,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _Input(
            controller: passCtrl,
            hint: 'Create a password',
            prefix: Icon(Icons.lock_outline,
                size: 18, color: _p.mutedText),
            obscure: obscure1,
            suffix: IconButton(
              onPressed: onToggleObscure1,
              icon: Icon(
                obscure1
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: _p.mutedText,
              ),
            ),
          ),
          const SizedBox(height: 14),

          Text(
            'Confirm Password',
            style: TextStyle(
              color: _p.text,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _Input(
            controller: confirmCtrl,
            hint: 'Re-enter your password',
            prefix: Icon(Icons.lock_outline,
                size: 18, color: _p.mutedText),
            obscure: obscure2,
            suffix: IconButton(
              onPressed: onToggleObscure2,
              icon: Icon(
                obscure2
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: _p.mutedText,
              ),
            ),
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              _AgreeCheck(
                value: agree,
                onChanged: onToggleAgree,
              ),
              const Spacer(),
              TextButton(
                onPressed: onGoLogin,
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  foregroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Have an account?',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          _PrimaryButton(
            text: 'Sign Up',
            onPressed: () {},
          ),

          const SizedBox(height: 14),
          Center(
            child: Text(
              'Or continue with',
              style: TextStyle(
                color: _p.mutedText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIconCircle(
                assetPath: AppAssets.google,
                onTap: () {},
              ),
              const SizedBox(width: 26),
              _SocialIconCircle(
                assetPath: AppAssets.microsoft,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AgreeCheck extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AgreeCheck({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Row(
      children: [
        SizedBox(
          height: 22,
          width: 22,
          child: Checkbox(
            value: value,
            onChanged: (v) => onChanged(v ?? false),
            side: BorderSide(color: _p.border),
            activeColor: AppColors.primary,
            checkColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'I agree',
          style: TextStyle(
            color: _p.mutedText,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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

class _SocialIconCircle extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const _SocialIconCircle({
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: _p.isDark ? const Color(0x14000000) : _p.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _p.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}