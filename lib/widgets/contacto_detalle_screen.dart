import 'package:flutter/material.dart';

import '../theme/eco_colors.dart';

/// Plantilla de "ficha de contacto" reutilizada por WF-10 (Detalle del
/// gestor) y WF-19 (Detalle de autoridad): avatar + nombre + chip,
/// filas de Dirección/Teléfono/Correo/Horario, y botones LLAMAR /
/// CÓMO LLEGAR.
class ContactoDetalleScreen extends StatelessWidget {
  const ContactoDetalleScreen({
    super.key,
    required this.inicial,
    required this.nombre,
    required this.etiqueta,
    required this.direccion,
    required this.telefono,
    required this.correo,
    required this.horario,
    this.onLlamar,
    this.onComoLlegar,
  });

  final String inicial;
  final String nombre;
  final String etiqueta;
  final String direccion;
  final String telefono;
  final String correo;
  final String horario;
  final VoidCallback? onLlamar;
  final VoidCallback? onComoLlegar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: 'Detalle'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: EcoColors.primaryContainer,
                        child: Text(
                          inicial,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: EcoColors.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nombre,
                              style: const TextStyle(
                                fontSize: 20,
                                height: 28 / 20,
                                fontWeight: FontWeight.bold,
                                color: EcoColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: EcoColors.primaryContainer,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                etiqueta,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: EcoColors.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.location_on_rounded,
                    label: 'Dirección',
                    value: direccion,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.call_rounded,
                    label: 'Teléfono',
                    value: telefono,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.email_rounded,
                    label: 'Correo',
                    value: correo,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.access_time_rounded,
                    label: 'Horario',
                    value: horario,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: FilledButton(
                            onPressed: onLlamar,
                            style: FilledButton.styleFrom(
                              backgroundColor: EcoColors.primary,
                              foregroundColor: EcoColors.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: const Text(
                              'LLAMAR',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 44,
                          child: OutlinedButton(
                            onPressed: onComoLlegar,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: EcoColors.primary,
                              side: const BorderSide(
                                color: Color(0xFF73796D),
                                width: 1.4,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: const Text(
                              'CÓMO LLEGAR',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: EcoColors.outline, width: 1.4),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: EcoColors.primaryContainer,
            child: Icon(icon, size: 18, color: EcoColors.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w500,
                    color: EcoColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 20 / 14,
                    color: EcoColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: const BoxDecoration(
        color: EcoColors.background,
        border: Border(bottom: BorderSide(color: EcoColors.outline)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: EcoColors.onSurface,
            onPressed: () => Navigator.maybePop(context),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              height: 28 / 20,
              fontWeight: FontWeight.bold,
              color: EcoColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
