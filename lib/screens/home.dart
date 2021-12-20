import 'package:crafting_games/screens/craft_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogos'),
      ),
      body: _jogos(context),
    );
  }

  _jogos(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Material(
            child: InkWell(
              onTap: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CraftList()));
              },
              child: Container(
                height: 100,
                width: 150,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Icon(Icons.shield_outlined), Text('RPG do povão')],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
