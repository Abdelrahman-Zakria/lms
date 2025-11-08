import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedType = 'child';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Logo/Title Section
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.school,
                      size: 50,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    localizations?.appTitle ?? 'LMS',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              
              const SizedBox(height: 50),
              
              // Login Form
              LoginForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                selectedType: _selectedType,
                onTypeChanged: (type) {
                  setState(() {
                    _selectedType = type;
                  });
                },
                onLogin: _handleLogin,
                isLoading: _isLoading || authProvider.isLoading,
              ),
              
              const SizedBox(height: 24),
              
              // Welcome Message
              Text(
                localizations?.welcomeMessage ?? 'Welcome to our educational platform',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final localizations = AppLocalizations.of(context);
      
      final success = await authProvider.login(
        emailOrPhone: _emailController.text.trim(),
        password: _passwordController.text,
        type: _selectedType,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (success) {
          // Navigate to home screen
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                authProvider.errorMessage ?? 
                localizations?.loginFailed ?? 
                'Login failed',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
