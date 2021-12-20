import 'package:crafting_games/database/craft_dao.dart';
import 'package:crafting_games/models/craft.dart';
import 'package:flutter/material.dart';

class CraftForm extends StatefulWidget {
  @override
  _CraftFormState createState() => _CraftFormState();
}

class _CraftFormState extends State<CraftForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nivelController = TextEditingController();
  final CraftDao _dao = CraftDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo craft'),
      ),
      body: _form(),
    );
  }

  _form() {
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
                  final Craft novoCraft = Craft(0, name!, nivel!);
                  _dao.save(novoCraft).then((id) => Navigator.pop(context));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
