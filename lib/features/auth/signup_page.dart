import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import 'login_page.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});
  static const routePath = '/signup';

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  bool agree = false;
  bool obscure1 = true;
  bool obscure2 = true;
  bool isLoading = false;

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

  Future<void> _handleSignup() async {
    final name = nameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final pass = passCtrl.text;
    final confirm = confirmCtrl.text;

    if (name.isEmpty || email.isEmpty || pass.isEmpty) {
      _showError('يرجى ملء جميع الحقول');
      return;
    }
    if (pass != confirm) {
      _showError('كلمتا المرور غير متطابقتين');
      return;
    }
    if (pass.length < 8) {
      _showError('كلمة المرور يجب أن تكون 8 أحرف على الأقل');
      return;
    }
    if (!agree) {
      _showError('يجب الموافقة على الشروط والأحكام');
      return;
    }

    setState(() => isLoading = true);

    final success = await ref.read(authProvider.notifier).signup(name, email, pass);

    if (!mounted) return;
    setState(() => isLoading = false);

    if (success) {
      // logout local state — user must login manually after signup
      await ref.read(authProvider.notifier).logout();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إنشاء الحساب بنجاح! سجّل دخولك الآن'),
          backgroundColor: Color(0xFF34C759),
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.go(LoginPage.routePath);
    } else {
      final error = ref.read(authProvider).error ?? 'فشل إنشاء الحساب';
      _showError(error);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFFFF3B30),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: p.isDark ? [p.bgTop, p.bgBottom] : [p.bgTop, p.background],
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
                      isLoading: isLoading,
                      nameCtrl: nameCtrl,
                      emailCtrl: emailCtrl,
                      passCtrl: passCtrl,
                      confirmCtrl: confirmCtrl,
                      onToggleAgree: (v) => setState(() => agree = v),
                      onToggleObscure1: () => setState(() => obscure1 = !obscure1),
                      onToggleObscure2: () => setState(() => obscure2 = !obscure2),
                      onGoLogin: () => Navigator.pop(context),
                      onSignUp: _handleSignup,
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
    final p = c(context);
    return Column(
      children: [
        Container(
          height: 92,
          width: 92,
          decoration: BoxDecoration(
            color: p.card,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: p.border),
            boxShadow: [
              BoxShadow(
                blurRadius: 26,
                spreadRadius: 2,
                color: p.isDark
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
            color: p.text,
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
            color: p.mutedText,
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
  final bool isLoading;

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final TextEditingController confirmCtrl;

  final ValueChanged<bool> onToggleAgree;
  final VoidCallback onToggleObscure1;
  final VoidCallback onToggleObscure2;
  final VoidCallback onGoLogin;
  final VoidCallback onSignUp;

  const _SignupCard({
    required this.agree,
    required this.obscure1,
    required this.obscure2,
    required this.isLoading,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
    required this.confirmCtrl,
    required this.onToggleAgree,
    required this.onToggleObscure1,
    required this.onToggleObscure2,
    required this.onGoLogin,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Label(text: 'Full Name', p: p),
          const SizedBox(height: 8),
          _Input(
            controller: nameCtrl,
            hint: 'Enter your full name',
            prefix: Icon(Icons.person_outline, size: 18, color: p.mutedText),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 14),

          _Label(text: 'Email Address', p: p),
          const SizedBox(height: 8),
          _Input(
            controller: emailCtrl,
            hint: 'example@company.com',
            prefix: Icon(Icons.mail_outline, size: 18, color: p.mutedText),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),

          _Label(text: 'Password', p: p),
          const SizedBox(height: 8),
          _Input(
            controller: passCtrl,
            hint: 'Create a password (min 8 chars)',
            prefix: Icon(Icons.lock_outline, size: 18, color: p.mutedText),
            obscure: obscure1,
            suffix: IconButton(
              onPressed: onToggleObscure1,
              icon: Icon(
                obscure1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: p.mutedText,
              ),
            ),
          ),
          const SizedBox(height: 14),

          _Label(text: 'Confirm Password', p: p),
          const SizedBox(height: 8),
          _Input(
            controller: confirmCtrl,
            hint: 'Re-enter your password',
            prefix: Icon(Icons.lock_outline, size: 18, color: p.mutedText),
            obscure: obscure2,
            suffix: IconButton(
              onPressed: onToggleObscure2,
              icon: Icon(
                obscure2 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: p.mutedText,
              ),
            ),
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              _AgreeCheck(value: agree, onChanged: onToggleAgree),
              const Spacer(),
              TextButton(
                onPressed: onGoLogin,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
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
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
                    ),
            ),
          ),

          const SizedBox(height: 14),
          Center(
            child: Text(
              'Or continue with',
              style: TextStyle(color: p.mutedText, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIconCircle(assetPath: AppAssets.google, onTap: () {}),
              const SizedBox(width: 26),
              _SocialIconCircle(assetPath: AppAssets.microsoft, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  final dynamic p;
  const _Label({required this.text, required this.p});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: p.text, fontSize: 12.5, fontWeight: FontWeight.w600),
    );
  }
}

class _AgreeCheck extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _AgreeCheck({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: value,
              onChanged: (v) => onChanged(v ?? false),
              side: BorderSide(color: p.border),
              activeColor: AppColors.primary,
              checkColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 6),
            Text(
              'I agree',
              style: TextStyle(color: p.mutedText, fontSize: 12.5, fontWeight: FontWeight.w500),
            ),
          ],
        ),
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
    final p = c(context);
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: TextStyle(color: p.text, fontSize: 14.5),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: p.mutedText, fontSize: 13.5),
        prefixIcon: prefix,
        suffixIcon: suffix,
        filled: true,
        fillColor: p.isDark ? const Color(0x14000000) : p.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _SocialIconCircle extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;
  const _SocialIconCircle({required this.assetPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: p.isDark ? const Color(0x14000000) : p.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: p.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
