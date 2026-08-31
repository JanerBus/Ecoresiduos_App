import 'dart:io';

import 'package:flutter/material.dart';

import '../models/waste_item.dart';
import '../theme/eco_colors.dart';

/// WF-07 — Información del residuo
class InformacionResiduoScreen extends StatelessWidget {
  const InformacionResiduoScreen({
    super.key,
    required this.item,
    this.onVerManejo,
  });

  final WasteItem item;
  final VoidCallback? onVerManejo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(title: item.nombre),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FotoResiduo(imagenPath: item.imagenPath),
                    const SizedBox(height: 16),
                    Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: EcoColors.background,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: const Color(0xFF73796D),
                          width: 1.4,
                        ),
                      ),
                      child: Text(
                        item.etiquetaCategoria,
                        style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w500,
                          color: EcoColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Descripción',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w500,
                        color: EcoColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.descripcion,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 20 / 14,
                        color: EcoColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Características',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w500,
                        color: EcoColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.caracteristicas,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 20 / 14,
                        color: EcoColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: FilledButton(
                        onPressed: onVerManejo,
                        style: FilledButton.styleFrom(
                          backgroundColor: EcoColors.primary,
                          foregroundColor: EcoColors.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: const Text(
                          'VER MANEJO RECOMENDADO',
                          style: TextStyle(fontSize: 14, letterSpacing: 0.4),
                        ),
                      ),
                    ),
                  ],
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

class _FotoResiduo extends StatelessWidget {
  const _FotoResiduo({this.imagenPath});

  final String? imagenPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: imagenPath != null
            ? Image.file(File(imagenPath!), fit: BoxFit.cover)
            : Container(
                color: const Color(0xFFDFE4D7),
                child: const Center(
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.photo_camera_rounded,
                      color: EcoColors.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
