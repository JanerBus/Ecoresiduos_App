import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/autoridad_ambiental.dart';
import '../models/gestor.dart';

/// Servicio para consultar gestores y autoridades ambientales.
class DirectorioService {
  
  Future<List<Gestor>> gestores() async {
    try {
      final supabase = Supabase.instance.client;
      // Consultamos a perfiles_gestor
      final response = await supabase.from('perfiles_gestor').select();
      final List<dynamic> data = response;
      if (data.isEmpty) {
        throw Exception('Lista vacía');
      }
      return data.map((json) => Gestor.fromJson(json)).toList();
    } catch (e) {
      // Fallback temporal si la tabla no existe o Supabase falla
      return const [
        Gestor(
          nombre: 'Recicladora Santander',
          categoria: 'Plásticos y papel',
          distanciaKm: 2.3,
          direccion: 'Cra 20 #45-12, Bucaramanga',
          telefono: '(607) 000 0000',
          correo: 'contacto@ejemplo.com',
          horario: 'Lun–Vie 8:00–17:00',
        ),
        Gestor(
          nombre: 'EcoGestión Oriente',
          categoria: 'Residuos peligrosos',
          distanciaKm: 4.1,
          direccion: 'Cra 20 #45-12, Bucaramanga',
          telefono: '(607) 000 0000',
          correo: 'contacto@ejemplo.com',
          horario: 'Lun–Vie 8:00–17:00',
        ),
        Gestor(
          nombre: 'Reciclaje Bucaramanga',
          categoria: 'Multimaterial',
          distanciaKm: 5.0,
          direccion: 'Cra 20 #45-12, Bucaramanga',
          telefono: '(607) 000 0000',
          correo: 'contacto@ejemplo.com',
          horario: 'Lun–Vie 8:00–17:00',
        ),
      ];
    }
  }

  Future<List<AutoridadAmbiental>> autoridades() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('autoridades_ambientales').select();
      final List<dynamic> data = response;
      if (data.isEmpty) {
        throw Exception('Lista vacía');
      }
      return data.map((json) => AutoridadAmbiental.fromJson(json)).toList();
    } catch (e) {
      // Fallback temporal
      return const [
        AutoridadAmbiental(
          nombre: 'CDMB',
          descripcion: 'Autoridad ambiental regional',
          direccion: 'Cra 20 #45-12, Bucaramanga',
          telefono: '(607) 000 0000',
          correo: 'contacto@ejemplo.com',
          sitioWeb: 'Lun–Vie 8:00–17:00',
        ),
        AutoridadAmbiental(
          nombre: 'Alcaldía de Bucaramanga',
          descripcion: 'Secretaría de Medio Ambiente',
          direccion: 'Cra 20 #45-12, Bucaramanga',
          telefono: '(607) 000 0000',
          correo: 'contacto@ejemplo.com',
          sitioWeb: 'Lun–Vie 8:00–17:00',
        ),
        AutoridadAmbiental(
          nombre: 'ANLA',
          descripcion: 'Autoridad Nacional de Licencias',
          direccion: 'Cra 20 #45-12, Bucaramanga',
          telefono: '(607) 000 0000',
          correo: 'contacto@ejemplo.com',
          sitioWeb: 'Lun–Vie 8:00–17:00',
        ),
      ];
    }
  }
}
