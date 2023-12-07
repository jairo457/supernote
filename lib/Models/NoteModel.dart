// Generated by https://quicktype.io

class NoteModel {
  int? idnote;
  int? note;
  String? title;
  String? description;
  int? importancia;
  int? notificacion;
  String? tiempo;

  NoteModel({
    this.idnote,
    this.note,
    this.title,
    this.description,
    this.importancia,
    this.notificacion,
    this.tiempo,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      idnote: map['IdNote'],
      note: map['note'],
      title: map['title'] ?? '',
      //cualense ??, si es nulo lo de la izquierda
      //asigna lo de la derecha
      description: map['description'] ?? '',
      importancia: map['importancia'],
      notificacion: map['notificacion'],
      tiempo: map['tiempo'],
    );
  }
}