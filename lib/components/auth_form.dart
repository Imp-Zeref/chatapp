import 'dart:io';

import 'package:chatapp/components/user_image_picker.dart';
import 'package:chatapp/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubimit;

  const AuthForm({super.key, required this.onSubimit});
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red[900],
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignUp) {
      return _showError('Imagem não selecionada');
    }

    widget.onSubimit(_formData);
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
              UserImagePicker(
                onImagePick: _handleImagePick,
              ),
            if (_formData.isSignUp)
              TextFormField(
                key: const ValueKey('name'),
                initialValue: _formData.name,
                onChanged: (name) => _formData.name = name,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (name) {
                  final name1 = name ?? '';

                  if (name1.trim().length < 5) {
                    return 'O nome deve ter pelo menos 5 caracteres';
                  }
                  return null;
                },
              ),
            TextFormField(
              key: const ValueKey('email'),
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (email1) {
                final email = email1 ?? '';

                if (!email.contains("@")) {
                  return 'O email não é valido';
                }
                return null;
              },
            ),
            TextFormField(
              key: const ValueKey('password'),
              decoration: const InputDecoration(labelText: 'Senha'),
              initialValue: _formData.password,
              onChanged: (password) => _formData.password = password,
              obscureText: true,
              validator: (password1) {
                final password = password1 ?? '';

                if (password.length < 6) {
                  return 'A senha deve ter no mínimo 6 caracteres';
                }
                return null;
              },
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
