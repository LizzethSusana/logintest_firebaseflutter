import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // El AuthGate redirigirá automáticamente al Login
            },
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Sesión activa', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('UID: ${user.uid}', textAlign: TextAlign.center),
                if (user.email != null)
                  Text('Email: ${user.email}'),
                const SizedBox(height: 8),

                // Mostrar si el correo está verificado o no
                Text(
                  user.emailVerified
                      ? 'Correo verificado ✅'
                      : 'Correo no verificado ❌',
                  style: TextStyle(
                    color: user.emailVerified ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 8),

                // Botón para enviar correo de verificación
                if (!user.emailVerified)
                  ElevatedButton(
                    onPressed: () async {
                      await user.sendEmailVerification();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Correo de verificación enviado.'),
                        ),
                      );
                    },
                    child: const Text('Enviar verificación'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
