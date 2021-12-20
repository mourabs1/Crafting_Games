import 'package:crafting_games/database/craft_dao.dart';
import 'package:crafting_games/models/craft.dart';
import 'package:flutter/material.dart';

class CraftEdit extends StatefulWidget {
  final Craft craft;

  CraftEdit(this.craft);
  @override
  _CraftEditState createState() => _CraftEditState();
}

class _CraftEditState extends State<CraftEdit> {
  late TextEditingController _nameController;
  late TextEditingController _nivelController;
  final CraftDao _dao = CraftDao();

  @override
  void initState() {
    _nameController = new TextEditingController(text: widget.craft.name);
    _nivelController =
        new TextEditingController(text: widget.craft.nivel.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.craft.name),
      ),
      body: _formEdit(),
    );
  }

  _formEdit() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nome',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: _nivelController,
              decoration: InputDecoration(
                labelText: 'Nível',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: TextButton(
                child: Text('SALVAR'),
                onPressed: () {
                  final String? name = _nameController.text;
                  final int? nivel = int.tryParse(_nivelController.text);
                  final Craft editCraft = Craft(widget.craft.id, name!, nivel!);
                  _dao.update(editCraft).then((id) => Navigator.pop(context));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
