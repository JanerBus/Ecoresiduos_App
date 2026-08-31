/// Un gestor certificado de residuos (WF-09, WF-10).
class Gestor {
  const Gestor({
    required this.nombre,
    required this.categoria,
    required this.distanciaKm,
    required this.direccion,
    required this.telefono,
    required this.correo,
    required this.horario,
  });

  factory Gestor.fromJson(Map<String, dynamic> json) {
    return Gestor(
      nombre: json['razon_social']?.toString() ?? '',
      // Usaremos el municipio temporalmente o un valor por defecto
      categoria: json['municipio']?.toString() ?? 'Gestor Autorizado', 
      distanciaKm: 0.0, // Pendiente de cálculo por geolocalización
      direccion: json['direccion']?.toString() ?? '',
      telefono: json['telefono_contacto']?.toString() ?? '',
      correo: json['email_contacto']?.toString() ?? '',
      horario: json['estado_verificacion'] == 'verificado' ? 'Verificado' : 'Pendiente',
    );
  }

  final String nombre;

  /// Ej. "Plásticos y papel".
  final String categoria;
  final double distanciaKm;
  final String direccion;
  final String telefono;
  final String correo;
  final String horario;
}
