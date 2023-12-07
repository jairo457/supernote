import 'package:flutter/material.dart';
import 'package:super_note/Models/NoteModel.dart';
import 'package:super_note/Screens/NoteEdit.dart';
import 'package:super_note/database/Masterdb.dart';

class NoteWidgetViewCube extends StatelessWidget {
  NoteWidgetViewCube(
      {super.key,
      required this.noteModel,
      this.masterDB}); //Las {} indican que los parametros son nombrado

  NoteModel noteModel;
  MasterDB? masterDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.green),
      child: Row(
        children: [
          Column(
            children: [Text(noteModel.title!)],
          ),
          Expanded(child: Container()), //Se expande lo mas que puede
          Column(
            children: [
              GestureDetector(
                  //Para detectar eventos, en este caso en la imagen sin propiedad onpressed
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NoteEdit(noteModel: noteModel))),
                  child: Image.asset(
                    'assets/database.png',
                    height: 50,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: Text('¿Dese borrar la carrera?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  masterDB!
                                      .DELETE_Note('tblCarrera',
                                          noteModel.note.toString())
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'))
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
