import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _role = 'alumno';
  String? _error;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(controller: _password, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              value: _role,
              items: const [
                DropdownMenuItem(value: 'alumno', child: Text('Alumno')),
                DropdownMenuItem(value: 'tutor', child: Text('Tutor')),
              ],
              onChanged: (v) => setState(() => _role = v as String),
              decoration: const InputDecoration(labelText: 'Rol'),
            ),
            if (_error != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(_error!, style: const TextStyle(color: Colors.red))),
            const Spacer(),
            CustomButton(
              text: 'Crear cuenta',
              loading: _loading,
              onPressed: () async {
                setState(() { _error = null; _loading = true; });
                try {
                  if (!isValidEmail(_email.text)) throw Exception('Email inválido');
                  if (!isStrongPassword(_password.text)) throw Exception('La contraseña debe tener 8+ caracteres y un número');
                  await context.read<AuthProvider>().register(_email.text, _password.text, _role);
                  if (mounted) Navigator.pop(context);
                } catch (e) {
                  setState(() => _error = e.toString());
                } finally {
                  if (mounted) setState(() => _loading = false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
