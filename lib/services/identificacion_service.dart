import '../models/waste_item.dart';

/// Se lanza cuando el análisis no logra reconocer el residuo con
/// suficiente confianza (WF-12).
class ResiduoNoIdentificadoException implements Exception {}

/// Se lanza cuando ocurre un fallo al procesar la imagen (WF-13).
class ErrorProcesamientoException implements Exception {}

/// Se lanza cuando no hay conexión disponible para completar el análisis
/// (WF-14).
class SinConexionException implements Exception {}

/// Punto único donde se resuelve "¿qué residuo es este?".
///
/// Hoy devuelve datos de prueba con un retraso simulado. Cuando se integre
/// ML Kit, reemplaza el cuerpo de [identificar] por la inferencia real
/// (image labeling + el mapeo de etiquetas a categorías en español) sin
/// tener que tocar ninguna pantalla: todas dependen de esta interfaz.
class IdentificacionService {
  Future<WasteItem> identificar({required String imagePath}) async {
    await Future.delayed(const Duration(seconds: 2));

    // TODO: reemplazar por la llamada real a ML Kit + mapeo de etiquetas.
    return const WasteItem(
      nombre: 'Botella PET',
      categoria: 'Reciclable — Plástico',
      etiquetaCategoria: 'Reciclable',
      confianza: 92,
      descripcion:
          'Envase plástico fabricado en tereftalato de polietileno, '
          'comúnmente usado en bebidas.',
      caracteristicas:
          'Código de reciclaje 1 (PET). Reciclable en la mayoría de '
          'centros de acopio.',
      pasosManejo: [
        'Enjuaga el envase y retira etiquetas.',
        'Aplasta el envase para reducir volumen.',
        'Deposita en el contenedor de reciclables.',
        'Lleva a un gestor certificado si es en volumen.',
      ],
    );
  }
}
