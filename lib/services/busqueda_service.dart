import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/waste_item.dart';

/// Búsqueda de residuos por nombre o categoría conectada a Supabase.
class BusquedaService {
  
  /// Búsquedas recientes de ejemplo.
  Future<List<String>> busquedasRecientes() async {
    // TODO: reemplazar por historial real guardado localmente (SharedPreferences o Hive).
    return const ['Botella PET', 'Cartón', 'Pilas'];
  }

  Future<List<WasteItem>> buscar(String query) async {
    final supabase = Supabase.instance.client;
    
    try {
      if (query.trim().isEmpty) {
        // Retorna todos los residuos limitando a 50
        final response = await supabase.from('materiales_residuos').select().limit(50);
        final List<dynamic> data = response;
        return data.map((json) => WasteItem.fromJson(json)).toList();
      }
      
      // Búsqueda por nombre usando ilike (evitamos buscar en categoria por ser un tipo ENUM en Postgres)
      final response = await supabase
          .from('materiales_residuos')
          .select()
          .ilike('nombre_comun', '%$query%');
          
      final List<dynamic> data = response;
      return data.map((json) => WasteItem.fromJson(json)).toList();
      
    } catch (e) {
      // Fallback
      return [
        const WasteItem(
          nombre: 'Botella PET', 
          categoria: 'Reciclable — Plástico',
          etiquetaCategoria: 'Reciclable',
          confianza: 100,
          descripcion: 'Botella de plástico tipo PET.',
          caracteristicas: 'Plástico transparente',
          pasosManejo: ['Limpiar', 'Secar', 'Depositar en contenedor'],
        ),
      ];
    }
  }
}
