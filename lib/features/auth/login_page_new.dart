import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'forgot_password_page.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
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
  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool rememberMe = false;
  late AppPalette _p;

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
    if (!formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);
    final success =
        await authNotifier.login(emailCtrl.text.trim(), passCtrl.text);

    if (mounted) {
      if (success) {
        context.go('/dashboard-home');
      } else {
        final authState = ref.read(authProvider);
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            title: 'Login Error',
            message: authState.error ?? 'Login failed. Please try again.',
            actionLabel: 'Try Again',
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _p = c(context);
    final authState = ref.watch(authProvider);

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
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s24,
                vertical: AppSpacing.s20,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: AppSpacing.s16),
                      _buildLogo(),
                      SizedBox(height: AppSpacing.s32),
                      _buildLoginForm(authState),
                      SizedBox(height: AppSpacing.s24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
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
                color: _p.isDark ? Colors.black.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.15),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.s16),
            child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
          ),
        ),
        SizedBox(height: AppSpacing.s24),
        Text(
          'Security Dashboard',
          textAlign: TextAlign.center,
          style: AppTextStyles.h1.copyWith(color: _p.text),
        ),
        SizedBox(height: AppSpacing.s8),
        Text(
          'Sign in to access your security center',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: _p.mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(AuthState authState) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.s20),
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
          AppTextField(
            label: 'Username or Email',
            hint: 'Enter username or email',
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Username or email is required' : null,
            prefixIcon: Icon(Icons.mail_outline, color: _p.mutedText),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: AppSpacing.s16),
          AppTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: passCtrl,
            obscureText: obscurePassword,
            validator: (v) =>
                v == null || v.isEmpty ? 'Password is required' : null,
            prefixIcon: Icon(Icons.lock_outline, color: _p.mutedText),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: _p.mutedText,
              ),
              onPressed: () {
                setState(() => obscurePassword = !obscurePassword);
              },
            ),
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: AppSpacing.s12),
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: (value) {
                  setState(() => rememberMe = value ?? false);
                },
                activeColor: AppColors.primary,
              ),
              Text(
                'Remember me',
                style: AppTextStyles.body.copyWith(
                  color: _p.mutedText,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push(ForgotPasswordPage.routePath),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.s24),
          AppButton(
            label: 'Sign In',
            onPressed: _handleLogin,
            isLoading: authState.isLoading,
            isEnabled: !authState.isLoading,
            prefixIcon: Icon(Icons.login, color: Colors.white),
          ),
          SizedBox(height: AppSpacing.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: AppTextStyles.body.copyWith(
                  color: _p.mutedText,
                ),
              ),
              TextButton(
                onPressed: () => context.push(SignupPage.routePath),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.s16),
          Center(
            child: Text(
              'Or continue with',
              style: AppTextStyles.caption.copyWith(
                color: _p.mutedText,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.s12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(
                icon: AppAssets.google,
                onTap: () {},
              ),
              SizedBox(width: AppSpacing.s24),
              _SocialButton(
                icon: AppAssets.microsoft,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: _p.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _p.border),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.s10),
          child: Image.asset(icon, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
