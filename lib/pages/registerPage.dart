import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF4256A4);
const Color kSecondaryColor = Color(0xFF333A40);
const Color kBackgroundColor = Color(0xFFF0F0FF);
const double kBorderRadius = 12.0;

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          disabledBackgroundColor: kPrimaryColor.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  final Function(String username, String email) onRegister;
  final VoidCallback onSwitchToLogin;

  const RegisterPage({
    super.key,
    required this.onRegister,
    required this.onSwitchToLogin,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _emailFocus = FocusNode();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onRegister(
        _usernameController.text,
        _emailController.text,
      );
    }
  }

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: kSecondaryColor,
        elevation: 0,
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _usernameController,
                    focusNode: _usernameFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                    decoration: const InputDecoration(hintText: "Create username"),
                    validator: (value) {
                      if (value == null || value.isEmpty) return '';
                      if (value.length < 4) return 'Username must be at least 4 characters.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
                    decoration: const InputDecoration(hintText: "Create password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) return '';
                      if (value.length < 6) return 'Password must be at least 6 characters.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(hintText: "Enter email"),
                    validator: (value) {
                      if (value == null || value.isEmpty || !_isEmailValid(value)) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    text: "Create",
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: widget.onSwitchToLogin,
                    child: const Text(
                      "Already have an account? Log in",
                      style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
