import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/eco_colors.dart';
import 'inicio_screen.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _registrar() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        setState(() {
          _errorMessage = 'Por favor, completa todos los campos.';
          _isLoading = false;
        });
        return;
      }

      if (password != confirmPassword) {
        setState(() {
          _errorMessage = 'Las contraseñas no coinciden.';
          _isLoading = false;
        });
        return;
      }

      if (password.length < 6) {
        setState(() {
          _errorMessage = 'La contraseña debe tener al menos 6 caracteres.';
          _isLoading = false;
        });
        return;
      }

      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      // Muestra un mensaje de éxito o navega directo (en Supabase, si requiere confirmación de email, el usuario se crea igual)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro exitoso. Iniciando sesión...'),
            backgroundColor: EcoColors.primary,
          ),
        );
        // Supabase inicia sesión automáticamente tras el signUp si no requiere confirmación obligatoria.
        // Asumiremos que el auth.onAuthStateChange en main lo mandará a Inicio, 
        // pero por si acaso, lo mandamos desde aquí:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => InicioScreen(
              onAbrirCamara: () {}, // Se inyectará desde main.dart luego
              onBuscarResiduo: () {},
              onGuiaDeManejo: () {},
              onGestoresCertificados: () {},
              onAutoridadesAmbientales: () {},
            ),
          ),
          (route) => false,
        );
      }
    } on AuthException catch (error) {
      setState(() => _errorMessage = error.message);
    } catch (e) {
      setState(() => _errorMessage = 'Ocurrió un error inesperado al registrarse.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: EcoColors.onSurface),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crear Cuenta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: EcoColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Únete para guardar tu historial de reciclaje',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: EcoColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 48),
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: EcoColors.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: EcoColors.onErrorContainer),
                    ),
                  ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Contraseña',
                    prefixIcon: const Icon(Icons.lock_reset),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 52,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _registrar,
                    style: FilledButton.styleFrom(
                      backgroundColor: EcoColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'REGISTRARSE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
