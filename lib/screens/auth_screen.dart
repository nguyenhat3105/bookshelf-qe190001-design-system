import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../core/validators.dart';
import '../widgets/design_components.dart';
import '../app/theme/app_theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.register});
  final bool register;
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final form = GlobalKey<FormState>();
  final email = TextEditingController(),
      password = TextEditingController(),
      confirm = TextEditingController();
  bool submitted = false, busy = false, hidePassword = true, hideConfirm = true;
  String? error;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    setState(() {
      submitted = true;
      error = null;
    });
    if (!form.currentState!.validate()) return;
    setState(() => busy = true);
    try {
      if (widget.register) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text,
        );
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text,
        );
      }
      if (!mounted) return;
      if (widget.register) notice(context, 'Registration successful');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() => error = e.message ?? e.code);
    } catch (e) {
      if (mounted) setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.register ? 'Register' : 'Login';
    return PopScope(
      canPop: !busy,
      child: Scaffold(
        appBar: AppBar(title: Text(name)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: form,
                autovalidateMode: submitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        widget.register
                            ? 'Create your account'
                            : 'Welcome back',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        widget.register
                            ? 'A private place for your reading journey.'
                            : 'Your next chapter is waiting.',
                        style: const TextStyle(color: AppColors.secondary),
                      ),
                      const SizedBox(height: 24),
                      FieldLabel(
                        'Email',
                        child: TextFormField(
                          key: const ValueKey('Email'),
                          controller: email,
                          enabled: !busy,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: Validators.email,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FieldLabel(
                        'Password',
                        child: TextFormField(
                          key: const ValueKey('Password'),
                          controller: password,
                          enabled: !busy,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              tooltip: hidePassword
                                  ? 'Show password'
                                  : 'Hide password',
                              onPressed: () =>
                                  setState(() => hidePassword = !hidePassword),
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          onChanged: (_) {
                            if (submitted) form.currentState?.validate();
                          },
                          validator: (v) =>
                              Validators.password(v, register: widget.register),
                        ),
                      ),
                      if (widget.register) ...[
                        const SizedBox(height: 16),
                        FieldLabel(
                          'Confirm password',
                          child: TextFormField(
                            key: const ValueKey('Confirm password'),
                            controller: confirm,
                            enabled: !busy,
                            obscureText: hideConfirm,
                            decoration: InputDecoration(
                              hintText: 'Re-enter your password',
                              suffixIcon: IconButton(
                                tooltip: hideConfirm
                                    ? 'Show confirm password'
                                    : 'Hide confirm password',
                                onPressed: () =>
                                    setState(() => hideConfirm = !hideConfirm),
                                icon: Icon(
                                  hideConfirm
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                            validator: (v) =>
                                Validators.confirm(v, password.text),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: busy ? null : submit,
                        child: busy
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(name),
                      ),
                      if (error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ErrorState(error!),
                        ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: busy
                            ? null
                            : () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AuthScreen(register: !widget.register),
                                ),
                              ),
                        child: Text(widget.register ? 'Login' : 'Register'),
                      ),
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
}
