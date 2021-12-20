import 'package:crafting_games/database/craft_dao.dart';
import 'package:crafting_games/models/craft.dart';
import 'package:crafting_games/screens/craft_edit.dart';
import 'package:crafting_games/screens/craft_form.dart';
import 'package:flutter/material.dart';

class CraftList extends StatefulWidget {
  @override
  _CraftListState createState() => _CraftListState();
}

class _CraftListState extends State<CraftList> {
  final CraftDao _dao = CraftDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de crafts'),
        ),
        body: _list(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CraftForm()))
                .then((value) => setState(() {}));
          },
          child: Icon(Icons.add),
        ));
  }

  _list() {
    return FutureBuilder<List<Craft>>(
      initialData: [],
      future: _dao.findAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            _loading();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            final List<Craft> crafts = snapshot.data ?? [];
            return ListView.builder(
                itemCount: crafts.length,
                itemBuilder: (context, index) {
                  print('entrou');
                  final Craft craft = crafts[index];
                  return _CraftItem(
                    craft: craft,
                    onRemove: () {
                      _dao.delete(craft.id);
                      setState(() {
                        _dao.findAll();
                      });
                    },
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => CraftEdit(craft)))
                          .then((value) => setState(() {}));
                    },
                  );
                });
        }
        return Container();
      },
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _CraftItem extends StatelessWidget {
  final Craft? craft;
  final Function? onClick;
  final Function()? onRemove;

  _CraftItem({this.craft, this.onRemove, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick!(),
        title: Text(craft!.name),
        subtitle: Text(craft!.nivel.toString()),
        trailing: IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.close),
        ),
      ),
    );
  }
}
