import 'package:flutter/material.dart';

import '../models/gestor.dart';
import '../widgets/contacto_detalle_screen.dart';

/// WF-10 — Detalle del gestor
class GestorDetalleScreen extends StatelessWidget {
  const GestorDetalleScreen({
    super.key,
    required this.gestor,
    this.onLlamar,
    this.onComoLlegar,
  });

  final Gestor gestor;
  final VoidCallback? onLlamar;
  final VoidCallback? onComoLlegar;

  @override
  Widget build(BuildContext context) {
    return ContactoDetalleScreen(
      inicial: 'M',
      nombre: gestor.nombre,
      etiqueta: gestor.categoria,
      direccion: gestor.direccion,
      telefono: gestor.telefono,
      correo: gestor.correo,
      horario: gestor.horario,
      // TODO: usar url_launcher para tel:/geo: cuando se integre.
      onLlamar: onLlamar,
      onComoLlegar: onComoLlegar,
    );
  }
}
