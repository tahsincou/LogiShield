import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import 'package:logishield/shared/theme/app_spacing.dart';
import 'package:logishield/shared/widgets/app_button.dart';
import 'package:logishield/shared/widgets/app_text_field.dart';
import '../providers/auth_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController(text: "demo@logishield.com");

  final _passwordController = TextEditingController(text: "password");

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await ref
        .read(authNotifierProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (!mounted) return;

    if (success) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.appName,
                      style: theme.textTheme.displayMedium,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Delayed parcel monitoring for faster operational action.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }

                        if (!value.contains('@')) {
                          return 'Enter a valid email';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.md),

                    AppTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _login(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }

                        return null;
                      },
                    ),

                    if (state.error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colors.error.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 20,
                              color: colors.onErrorContainer,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                state.error!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colors.onErrorContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: AppSpacing.lg),

                    AppButton(
                      text: context.l10n.login,
                      icon: Icons.arrow_forward,
                      isLoading: state.isLoading,
                      onPressed: _login,
                    ),

                    // const SizedBox(height: 28),

                    // Center(
                    //   child: EnvironmentBadge(
                    //     onLongPress: () async {
                    //       final changed = await showEnvironmentBottomSheet(
                    //         context,
                    //       );

                    //       if (!context.mounted) return;

                    //       if (changed == true) {
                    //         context.go('/splash');
                    //       }
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 24),

                    Text(
                      'LogiShield • Delayed Parcel Monitor',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
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
