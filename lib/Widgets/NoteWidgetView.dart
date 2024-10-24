import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:super_note/Assets/global_values.dart';
import 'package:super_note/Models/NoteModel.dart';
import 'package:super_note/Screens/NoteEdit.dart';
import 'package:super_note/Utils/Noti_service.dart';
import 'package:super_note/database/Masterdb.dart';

class NoteWidgetView extends StatelessWidget {
  NoteWidgetView(
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
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 210, 243, 211)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 240, 169)),
                    child: Column(
                      children: [
                        Text(noteModel.title!),
                        Text(noteModel.description!.length > 40
                            ? noteModel.description!.substring(0, 40)
                            : noteModel.description!)
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NoteEdit(noteModel: noteModel)))),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Mensaje del sistema'),
                            content: Text('¿Dese borrar la nota?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    masterDB!
                                        .DELETE_Note('tblNotes',
                                            noteModel.idnote.toString())
                                        .then((value) {
                                      NotificationService()
                                          .cancel(noteModel.idnote!);
                                      GlobalValues.flagNote.value =
                                          !GlobalValues.flagNote.value;
                                      Get.back();
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
      ),
    );
  }
}
