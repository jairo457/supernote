import 'package:flutter/material.dart';
import 'package:super_note/Models/NoteModel.dart';
import 'package:super_note/Widgets/NoteWidgetView.dart';
import 'package:super_note/database/Masterdb.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  MasterDB? masterDB;
  //List<Favorite_model> list_cn = [];
  List<NoteModel>? list1 = [];
  late Future<List<NoteModel>> list2;
  List<String> list_fav = [];

  void initState() {
    super.initState();
    masterDB = MasterDB();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/popular');
          },
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: FutureBuilder(
        future: masterDB!.GETALL_Note(),
        builder: (context, AsyncSnapshot<List<NoteModel>?> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return NoteWidgetView(
                    noteModel: snapshot.data![index],
                    masterDB: masterDB,
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('Algo salio mal :('));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
