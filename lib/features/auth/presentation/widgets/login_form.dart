import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_localizations.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String selectedType;
  final ValueChanged<String> onTypeChanged;
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onLogin,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email/Phone Field
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            enabled: !widget.isLoading,
            decoration: InputDecoration(
              labelText: localizations?.emailOrPhone ?? 'Email or Phone',
              hintText: localizations?.emailOrPhoneHint ?? 'Enter your email or phone number',
              prefixIcon: const Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return localizations?.emailOrPhoneError ?? 'Please enter your email or phone number';
              }
              return null;
            },
          ),
          
          const SizedBox(height: AppConstants.defaultPadding),
          
          // Password Field
          TextFormField(
            controller: widget.passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            enabled: !widget.isLoading,
            decoration: InputDecoration(
              labelText: localizations?.password ?? 'Password',
              hintText: localizations?.passwordHint ?? 'Enter your password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations?.passwordError ?? 'Please enter your password';
              }
              if (value.length < 6) {
                return localizations?.passwordMinLengthError ?? 'Password must be at least 6 characters';
              }
              return null;
            },
            onFieldSubmitted: (_) {
              if (!widget.isLoading) {
                widget.onLogin();
              }
            },
          ),
          
          const SizedBox(height: AppConstants.defaultPadding),
          
          // Type Selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.selectedType,
                isExpanded: true,
                isDense: true,
                items: [
                  DropdownMenuItem(
                    value: 'child',
                    child: Text(localizations?.student ?? 'Student'),
                  ),
                  DropdownMenuItem(
                    value: 'parent',
                    child: Text(localizations?.parent ?? 'Parent'),
                  ),
                  DropdownMenuItem(
                    value: 'teacher',
                    child: Text(localizations?.teacher ?? 'Teacher'),
                  ),
                ],
                onChanged: widget.isLoading
                    ? null
                    : (value) {
                        if (value != null) {
                          widget.onTypeChanged(value);
                        }
                      },
              ),
            ),
          ),
          
          const SizedBox(height: AppConstants.largePadding),
          
          // Login Button
          ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onLogin,
            child: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(localizations?.login ?? 'Login'),
          ),
        ],
      ),
    );
  }
}
