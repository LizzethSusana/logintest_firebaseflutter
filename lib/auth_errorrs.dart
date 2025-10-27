// lib/auth_errors.dart
import 'package:firebase_auth/firebase_auth.dart';

/// Convierte los códigos de error de Firebase Auth en mensajes legibles.
String mapAuthErrorToMessage(Object e) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'invalid-email':
        return 'El correo electrónico no es válido.';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada.';
      case 'user-not-found':
      case 'wrong-password':
        return 'Usuario o contraseña incorrectos.';
      case 'email-already-in-use':
        return 'Este correo ya está registrado.';
      case 'weak-password':
        return 'La contraseña es demasiado débil.';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      case 'network-request-failed':
        return 'Error de red. Revisa tu conexión a Internet.';
      default:
        return e.message ?? 'Ocurrió un error (${e.code}).';
    }
  }

  // Errores no relacionados con FirebaseAuthException
  return 'Ocurrió un error inesperado. Intenta de nuevo.';
}
