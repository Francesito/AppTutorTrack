import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import 'register_screen.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _error;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('AppTutorTrack', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 8),
                TextField(controller: _password, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
                if (_error != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(_error!, style: const TextStyle(color: Colors.red))),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Ingresar',
                  loading: _loading,
                  onPressed: () async {
                    setState(() { _error = null; _loading = true; });
                    try {
                      if (!isValidEmail(_email.text)) throw Exception('Email inválido');
                      await context.read<AuthProvider>().login(_email.text, _password.text);
                    } catch (e) {
                      setState(() => _error = e.toString());
                    } finally {
                      if (mounted) setState(() => _loading = false);
                    }
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                  child: const Text('Crear cuenta'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
