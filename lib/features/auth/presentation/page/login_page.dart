import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grand_library/core/routes/app_router.dart';
import 'package:grand_library/features/auth/presentation/providers/auth_provider.dart';
import 'package:grand_library/features/auth/presentation/widget/custom_text_field.dart';
import 'package:grand_library/features/auth/presentation/widget/loading_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> loginEmail() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();

    final success = await auth.loginWithEmail(
      email: _email.text.trim(),
      password: _password.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, AppRouter.dashboard);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.errorMessage ?? "Login gagal")),
      );
    }
  }

  Future<void> loginGoogle() async {
    final auth = context.read<AuthProvider>();

    final success = await auth.loginWithGoogle();

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(context, AppRouter.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().isLoading;

    return LoadingOverlay(
      isLoading: loading,

      message: "Login...",

      child: Scaffold(
        backgroundColor: const Color(0xffF8F5F2),

        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),

              child: Form(
                key: _formKey,

                child: Column(
                  children: [
                    const Icon(
                      Icons.menu_book_rounded,
                      size: 90,
                      color: Color(0xff6D4C41),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Grand Library",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Toko Buku Digital",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    const SizedBox(height: 35),

                    Card(
                      elevation: 6,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(22),

                        child: Column(
                          children: [
                            CustomTextField(
                              label: "Email",

                              hint: "Masukkan email",

                              controller: _email,

                              keyboardType: TextInputType.emailAddress,

                              prefixIcon: const Icon(Icons.email),

                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Email wajib diisi";
                                }

                                if (!EmailValidator.validate(v)) {
                                  return "Email tidak valid";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                              label: "Password",

                              hint: "Masukkan Password",

                              controller: _password,

                              obscureText: hidePassword,

                              prefixIcon: const Icon(Icons.lock),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },

                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),

                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Password wajib diisi";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 30),

                            SizedBox(
                              width: double.infinity,

                              height: 50,

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff6D4C41),

                                  foregroundColor: Colors.white,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),

                                onPressed: loginEmail,

                                child: const Text(
                                  "LOGIN",

                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,

                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            Row(
                              children: [
                                Expanded(child: Divider()),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),

                                  child: Text("ATAU"),
                                ),

                                Expanded(child: Divider()),
                              ],
                            ),

                            const SizedBox(height: 25),

                            SizedBox(
                              width: double.infinity,

                              height: 52,

                              child: OutlinedButton.icon(
                                icon: const Icon(
                                  Icons.g_mobiledata,

                                  size: 35,

                                  color: Colors.red,
                                ),

                                label: const Text(
                                  "Masuk dengan Google",

                                  style: TextStyle(fontSize: 16),
                                ),

                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),

                                onPressed: loginGoogle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Text("Belum punya akun?"),

                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRouter.register,
                            );
                          },

                          child: const Text("Daftar"),
                        ),
                      ],
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
