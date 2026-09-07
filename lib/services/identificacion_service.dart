import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
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
class IdentificacionService {
  Future<WasteItem> identificar({required String imagePath}) async {
    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw ErrorProcesamientoException();
      }

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.1,
        ),
      );

      final imageFile = File(imagePath);
      final imageBytes = await imageFile.readAsBytes();

      final prompt = '''
      Eres un experto ambiental colombiano. Analiza la imagen y determina qué residuo es.
      Clasifícalo ESTRICTAMENTE en una de estas categorías colombianas: PELIGROSO, INDUSTRIAL, RAEE, BIOSANITARIO, RECICLABLE, ORGANICO o ORDINARIO.
      Devuelve la respuesta en formato JSON puro (sin bloques de código markdown) con esta estructura exacta:
      {
        "nombre_comun": "Nombre común del objeto (ej. Botella de vidrio)",
        "categoria": "La categoría que le asignaste",
        "descripcion": "Breve impacto ambiental y por qué se clasifica así",
        "codigo": "N/A",
        "guia_manejo": [
          "Paso corto 1 para desecharlo o limpiarlo",
          "Paso corto 2",
          "Paso corto 3"
        ]
      }
      ''';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await model.generateContent(content);
      final responseText = response.text;
      
      if (responseText == null || responseText.isEmpty) {
        throw ResiduoNoIdentificadoException();
      }

      // Por si Gemini incluye bloques de código markdown a pesar de la instrucción
      var cleanJson = responseText;
      if (cleanJson.startsWith('```json')) {
        cleanJson = cleanJson.substring(7);
        if (cleanJson.endsWith('```')) {
          cleanJson = cleanJson.substring(0, cleanJson.length - 3);
        }
      }

      final jsonMap = jsonDecode(cleanJson);
      
      return WasteItem.fromJson(jsonMap, imagePath: imagePath);

    } catch (e) {
      if (e is ResiduoNoIdentificadoException || e is ErrorProcesamientoException) {
        rethrow;
      }
      // Cualquier otro error de red, parsing o modelo lo tomamos como procesamiento fallido
      throw ErrorProcesamientoException();
    }
  }
}
