import 'package:flutter/material.dart';

import '../theme/eco_colors.dart';
import '../widgets/categoria_chip.dart';
import '../widgets/pasos_manejo_list.dart';

/// WF-17 — Guía de manejo general
///
/// A diferencia de WF-08 (que muestra el manejo de un residuo puntual ya
/// identificado), esta pantalla es una guía general por categoría, a la
/// que se llega desde Inicio sin haber escaneado nada.
class GuiaManejoGeneralScreen extends StatefulWidget {
  const GuiaManejoGeneralScreen({super.key});

  @override
  State<GuiaManejoGeneralScreen> createState() =>
      _GuiaManejoGeneralScreenState();
}

class _GuiaManejoGeneralScreenState extends State<GuiaManejoGeneralScreen> {
  static const _pasosPorCategoria = {
    'Reciclable': [
      'Enjuaga el envase y retira etiquetas.',
      'Aplasta el envase para reducir volumen.',
      'Deposita en el contenedor de reciclables.',
      'Lleva a un gestor certificado si es en volumen.',
    ],
    'Orgánico': [
      'Separa los residuos de comida de otros materiales.',
      'Deposita en un recipiente con tapa para evitar olores.',
      'Lleva a un punto de compostaje si tu zona lo ofrece.',
    ],
    'Peligroso': [
      'No lo mezcles con residuos comunes.',
      'Guárdalo en su empaque original si es posible.',
      'Llévalo a un gestor certificado de residuos peligrosos.',
    ],
  };

  String _categoria = 'Reciclable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: 'Guía de manejo'),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  for (final categoria in _pasosPorCategoria.keys) ...[
                    CategoriaChip(
                      label: categoria,
                      selected: categoria == _categoria,
                      onTap: () => setState(() => _categoria = categoria),
                    ),
                    const SizedBox(width: 12),
                  ],
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: PasosManejoList(
                  pasos: _pasosPorCategoria[_categoria]!,
                ),
              ),
            ),
          ],
        ),
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
