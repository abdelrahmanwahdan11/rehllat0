import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/services/app_state.dart';
import '../onboarding/role_selection_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({required this.appState, super.key});

  static const String routeName = '/auth';

  final AppState appState;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isSubmitting = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) {
      return;
    }
    setState(() {
      _isSubmitting = false;
    });
    Navigator.of(context).pushReplacementNamed(RoleSelectionScreen.routeName);
  }

  Future<void> _continueAsGuest() async {
    await widget.appState.setUserRole('Seeker');
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(RoleSelectionScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.getString('app_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final bool isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
                  if (!isValid) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  if (value.length < 6) {
                    return 'Min 6 chars';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator.adaptive()
                      : Text(l10n.getString('cta_done')),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _continueAsGuest();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Guest'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
