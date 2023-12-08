import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_note/Models/NoteModel.dart';
import 'package:super_note/Utils/Noti_service.dart';
import 'package:super_note/database/Masterdb.dart';

class NoteEdit extends StatefulWidget {
  NoteEdit({super.key, this.noteModel});

  NoteModel? noteModel;

  @override
  State<NoteEdit> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<NoteEdit> {
  DateTime fecha = DateTime.now();
  RxString fech = RxString('');
  RxInt dropDownValue = RxInt(1); //importancia
  String id = '';
  int temp = 0;
  int tempi = 1;
  RxInt dropDownValue2 = RxInt(1); //notificacion
  final check_1 = false.obs;
  final flag_1 = false.obs;
  final check_2 = false.obs;
  final band = false.obs;
  List<DropdownMenuItem> import = [
    DropdownMenuItem(value: 1, child: Text('Poco importante')),
    DropdownMenuItem(value: 2, child: Text('Importante')),
    DropdownMenuItem(value: 3, child: Text('Muy importante'))
  ];
  List<DropdownMenuItem> record = [
    DropdownMenuItem(value: 1, child: Text('Una vez')),
    DropdownMenuItem(value: 2, child: Text('Cada hora')),
    DropdownMenuItem(value: 3, child: Text('Cada dia')),
    DropdownMenuItem(value: 4, child: Text('Cada semana')),
    DropdownMenuItem(value: 5, child: Text('Cada minuto'))
  ];

  TextEditingController TxtTitle = TextEditingController();
  TextEditingController TxtDescription = TextEditingController();
  //Sacamos variables por que
  //si estuvieran adentro del build se reiniciarian en cada setState

  MasterDB? masterDB;

  @override
  void initState() {
    super.initState();
    masterDB = MasterDB();

    if (widget.noteModel != null) {
      TxtTitle.text = widget.noteModel!.title!;
      TxtDescription.text = widget.noteModel!.description!;
      check_1.value = widget.noteModel!.notificacion! != 0 ? true : false;
      check_2.value = widget.noteModel!.importancia! != 0 ? true : false;
      dropDownValue2.value = widget.noteModel!.notificacion! != 0
          ? widget.noteModel!.notificacion!
          : 0;
      fecha = widget.noteModel!.notificacion! != 0
          ? DateTime.parse(widget.noteModel!.tiempo.toString())
          : DateTime.now();
      fech.value = widget.noteModel!.notificacion! != 0
          ? widget.noteModel!.tiempo.toString()
          : '';
      dropDownValue.value = widget.noteModel!.importancia! != 0
          ? widget.noteModel!.importancia!
          : 0;
      tempi = widget.noteModel!.idnote!;
    } else {
      GetId();
    }
  }

  GetId() async {
    tempi = await masterDB!.GETID_NOTI() ?? 0;
    tempi += 1;
    //id = temp.toString();
    //print('id ' + id);
  }

  @override
  Widget build(BuildContext context) {
    final circularMenu = CircularMenu(
        alignment: Alignment.bottomRight,
        toggleButtonColor: Colors.amber,
        items: [
          CircularMenuItem(
              icon: Icons.arrow_back,
              onTap: () {
                Get.back();
                //print(tempi);
              }),
          CircularMenuItem(
              icon: Icons.save,
              onTap: () {
                if (widget.noteModel == null) {
                  masterDB!.INSERT_Note('tblNotes', {
                    //El simbolo ! proteje contra  valores nulos
                    'title': TxtTitle.text == ''
                        ? 'Note' + tempi.toString()
                        : TxtTitle.text,
                    'description': TxtDescription.text,
                    'importancia': check_2.value ? dropDownValue.value : 0,
                    'notificacion': check_1.value ? dropDownValue2.value : 0,
                    'tiempo': check_1.value ? fecha.toString() : 'a',
                  });
                  if (check_1.value) {
                    //Notificacion
                    NotificationService().cancel(tempi);
                    switch (dropDownValue2.value) {
                      case 1:
                        NotificationService().scheduleNotification(
                            id: tempi,
                            title: TxtTitle.text.length > 20
                                ? TxtTitle.text.substring(0, 20)
                                : TxtTitle.text,
                            body: TxtDescription.text.length > 20
                                ? TxtDescription.text.substring(0, 20)
                                : TxtDescription.text,
                            scheduledNotificationDateTime: fecha);
                        break;
                      case 2:
                        NotificationService().PeriodicallyNotificationHour(
                          id: tempi,
                          title: TxtTitle.text.length > 20
                              ? TxtTitle.text.substring(0, 20)
                              : TxtTitle.text,
                          body: TxtDescription.text.length > 20
                              ? TxtDescription.text.substring(0, 20)
                              : TxtDescription.text,
                        );
                        break;
                      case 3:
                        NotificationService().PeriodicallyNotificationDaily(
                          id: tempi,
                          title: TxtTitle.text.length > 20
                              ? TxtTitle.text.substring(0, 20)
                              : TxtTitle.text,
                          body: TxtDescription.text.length > 20
                              ? TxtDescription.text.substring(0, 20)
                              : TxtDescription.text,
                        );
                        break;
                      case 4:
                        NotificationService().PeriodicallyNotificationWeek(
                          id: tempi,
                          title: TxtTitle.text.length > 20
                              ? TxtTitle.text.substring(0, 20)
                              : TxtTitle.text,
                          body: TxtDescription.text.length > 20
                              ? TxtDescription.text.substring(0, 20)
                              : TxtDescription.text,
                        );
                        break;
                      case 5:
                        NotificationService().PeriodicallyNotificationMinute(
                          id: tempi,
                          title: TxtTitle.text.length > 20
                              ? TxtTitle.text.substring(0, 20)
                              : TxtTitle.text,
                          body: TxtDescription.text.length > 20
                              ? TxtDescription.text.substring(0, 20)
                              : TxtDescription.text,
                        );
                        break;
                    }
                  }
                  Get.back();
                } else {
                  masterDB!.UPDATE_Note('tblNotes', {
                    //El simbolo ! proteje contra  valores nulos
                    'IdNote': widget.noteModel!.idnote!,
                    'title': TxtTitle.text == ''
                        ? 'Note' + tempi.toString()
                        : TxtTitle.text,
                    'description': TxtDescription.text,
                    'importancia': check_2.value ? dropDownValue.value : 0,
                    'notificacion': check_1.value ? dropDownValue2.value : 0,
                    'tiempo': check_1.value ? fecha.toString() : 'a',
                  });
                  if (check_1.value) {
                    //Notificacion
                    NotificationService().cancel(tempi);
                    switch (dropDownValue2.value) {
                      case 1:
                        NotificationService().scheduleNotification(
                            id: tempi,
                            title: TxtTitle.text.length > 20
                                ? TxtTitle.text.substring(0, 20)
                                : TxtTitle.text,
                            body: TxtDescription.text.length > 20
                                ? TxtDescription.text.substring(0, 20)
                                : TxtDescription.text,
                            scheduledNotificationDateTime: fecha);
                        break;
                      case 2:
                        NotificationService().PeriodicallyNotificationHour(
                          title: TxtTitle.text.length > 20
                              ? TxtTitle.text.substring(0, 20)
                              : TxtTitle.text,
                          body: TxtDescription.text.length > 20
                              ? TxtDescription.text.substring(0, 20)
                              : TxtDescription.text,
                        );
                        break;
                      case 3:
                        NotificationService().PeriodicallyNotificationDaily(
                          title: TxtTitle.text.length > 20
                              ? TxtTitle.text.substring(0, 20)
                              : TxtTitle.text,
                          body: TxtDescription.text.length > 20
                              ? TxtDescription.text.substring(0, 20)
                              : TxtDescription.text,
                        );
                        break;
                      case 4:
                        NotificationService().PeriodicallyNotificationWeek(
                          title: TxtTitle.text.length > 20
                              ? TxtTitle.text.substring(0, 20)
                              : TxtTitle.text,
                          body: TxtDescription.text.length > 20
                              ? TxtDescription.text.substring(0, 20)
                              : TxtDescription.text,
                        );
                        break;
                    }
                  }
                  Get.back();
                }
              }),
        ]);

    final TextButton datepic = TextButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            fecha = date;
            // print('change $date');
          }, onConfirm: (date) {
            fecha = date;
            fech.value =
                DateFormat('yyyy-MM-dd hh:mm').format(fecha).toString();
            //print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.es);
        },
        child: Text(
          'Seleccionar un dia',
          style: TextStyle(color: Colors.amber),
        ));

    final txtTitle = TextFormField(
      controller: TxtTitle,
      decoration: const InputDecoration(
          label: Text(
            'Titulo',
            style: TextStyle(color: Colors.amber),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber))),
    );

    final txtDescription = TextFormField(
      controller: TxtDescription,
      maxLines: null,
      decoration: const InputDecoration(
          label: Text(
            'Descripcion',
            style: TextStyle(color: Colors.amber),
          ),
          border: OutlineInputBorder()),
    );

    /*  DropdownButton importance = DropdownButton(
        value: dropDownValue,
        items: import,
        //convertimos lista de texto a su tipo hijo
        onChanged: (value) {
          dropDownValue = value;
        });*/

    /*DropdownButton recordi = DropdownButton(
        value: dropDownValue2.value,
        items: record,
        //convertimos lista de texto a su tipo hijo
        onChanged: (value) {
          dropDownValue2.value = value;
          print(dropDownValue2.value.toString());
        });*/

    return Scaffold(
        //Cuerpo
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: widget.noteModel == null
              ? Text('Nueva Nota')
              : Text('Editar nota'),
        ),
        body: Obx(
          () => Stack(children: [
            ListView(
                shrinkWrap: true,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      color: Color.fromARGB(255, 199, 196, 133),
                      child: Row(
                        children: [
                          Flexible(
                            child: CheckboxListTile(
                                title: Text('Recordatorio'),
                                value: check_1.value,
                                onChanged: (val) {
                                  val!
                                      ? check_1.value = true
                                      : check_1.value = false;
                                }),
                          ),
                          Flexible(
                            child: CheckboxListTile(
                                title: Text('Importancia'),
                                value: check_2.value,
                                onChanged: (val) {
                                  val!
                                      ? check_2.value = true
                                      : check_2.value = false;
                                }),
                          )
                        ],
                      )),
                  txtTitle,
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  txtDescription,
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  check_1.value
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber)),
                          child: Column(
                            children: [
                              DropdownButton(
                                  value: dropDownValue2.value,
                                  items: record,
                                  //convertimos lista de texto a su tipo hijo
                                  onChanged: (value) {
                                    dropDownValue2.value = value;
                                    //print(dropDownValue2.value.toString());
                                  }),
                              dropDownValue2.value == 1 ? datepic : Container(),
                              Text(fech.value),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 70,
                  ),
                  check_2.value
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber)),
                          child: Column(children: [
                            DropdownButton(
                                value: dropDownValue.value,
                                items: import,
                                //convertimos lista de texto a su tipo hijo
                                onChanged: (value) {
                                  dropDownValue.value = value;
                                }),
                          ]),
                        )
                      : Container(),
                ]),
            Align(
              alignment: Alignment.bottomRight,
              child: circularMenu,
            ),
          ]),
        )); //añadimos clumna con una serie de hijo
  }
}
