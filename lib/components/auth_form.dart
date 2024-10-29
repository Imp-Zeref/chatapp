import 'package:chatapp/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(16)),
            if (_formData.isSignUp)
              TextFormField(
                key: const ValueKey('name'),
                initialValue: _formData.name,
                onChanged: (name) => _formData.name = name,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
            TextFormField(
              key: const ValueKey('email'),
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            TextFormField(
              key: const ValueKey('password'),
              decoration: const InputDecoration(labelText: 'Senha'),
              initialValue: _formData.password,
              onChanged: (password) => _formData.password = password,
              obscureText: true,
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? "Entrar" : "Cadastrar")),
            TextButton(
              child: Text(_formData.isLogin
                  ? "Criar uma nova conta"
                  : 'Já possuí conta ?'),
              onPressed: () {
                setState(() {
                  _formData.toggleAuthMode();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
