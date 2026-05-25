import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'forgot_password_page.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/validators/form_validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/error_view.dart';
import '../../providers/auth_provider.dart';
import 'signup_page.dart';
import '../home/security_dashboard_home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  static const routePath = '/login';

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool rememberMe = false;
  bool obscure = true;
  bool isLoading = false;

  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final username = emailCtrl.text.trim();
    final password = passCtrl.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال اسم المستخدم وكلمة المرور'),
          backgroundColor: Color(0xFFFF3B30),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    final authNotifier = ref.read(authProvider.notifier);
    final success =
        await authNotifier.login(emailCtrl.text.trim(), passCtrl.text);

    setState(() => isLoading = false);

    if (mounted) {
      if (success) {
        context.go(SecurityDashboardHomePage.routePath);
      } else {
        final authState = ref.read(authProvider);
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            title: 'خطأ في تسجيل الدخول',
            message: authState.error ?? 'فشل تسجيل الدخول',
            actionLabel: 'إعادة محاولة',
          ),
        );
      }
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
            colors: _p.isDark
                ? [_p.bgTop, _p.bgBottom]
                : [_p.bgTop, _p.background],
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
                    _LoginCard(
                      rememberMe: rememberMe,
                      obscure: obscure,
                      isLoading: isLoading,
                      emailCtrl: emailCtrl,
                      passCtrl: passCtrl,
                      onToggleRemember: (v) => setState(() => rememberMe = v),
                      onToggleObscure: () => setState(() => obscure = !obscure),
                      onGoSignup: () => context.push(SignupPage.routePath),
                      onSignIn: _handleLogin,
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
                    : AppColors.primary.withValues(alpha: 0.18),
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
          'Security Dashboard',
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
          'Sign in to access your security center',
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

class _LoginCard extends StatelessWidget {
  final bool rememberMe;
  final bool obscure;
  final bool isLoading;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final ValueChanged<bool> onToggleRemember;
  final VoidCallback onToggleObscure;
  final VoidCallback onGoSignup;
  final VoidCallback onSignIn;

  const _LoginCard({
    required this.rememberMe,
    required this.obscure,
    required this.isLoading,
    required this.emailCtrl,
    required this.passCtrl,
    required this.onToggleRemember,
    required this.onToggleObscure,
    required this.onGoSignup,
    required this.onSignIn,
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
        boxShadow: _p.isDark
            ? null
            : [
                BoxShadow(
                  color: _p.shadow,
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Username or Email',
            style: TextStyle(
              color: _p.text,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _Input(
            controller: emailCtrl,
            hint: 'Enter username or email',
            prefix: Icon(Icons.person_outline,
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
            hint: 'Enter your password',
            prefix: Icon(Icons.lock_outline,
                size: 18, color: _p.mutedText),
            obscure: obscure,
            suffix: IconButton(
              onPressed: onToggleObscure,
              icon: Icon(
                obscure
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
              _RememberCheck(
                value: rememberMe,
                onChanged: onToggleRemember,
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push(ForgotPasswordPage.routePath),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  foregroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          _PrimaryButton(
            text: isLoading ? 'Signing in...' : 'Sign In',
            onPressed: isLoading ? () {} : onSignIn,
          ),

          // ✅ سطر Sign up
          const SizedBox(height: 12),
          _InlineSignup(onTap: onGoSignup),

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

class _InlineSignup extends StatelessWidget {
  final VoidCallback onTap;
  const _InlineSignup({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 6,
        children: [
          Text(
            "Don’t have an account?",
            style: TextStyle(
              color: _p.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12.8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RememberCheck extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _RememberCheck({required this.value, required this.onChanged});

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
          'Remember me',
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
        fillColor: _p.isDark
            ? const Color(0x14000000)
            : _p.background,
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