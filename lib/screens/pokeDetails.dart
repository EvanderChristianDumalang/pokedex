import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemonModel.dart';
import 'package:pokedex/utils/capitalizer.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  const PokeDetail({super.key, required this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    capitalizeFirstCharacter(pokemon.name.toString()),
                    style:
                        const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.types
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text("Height: ${pokemon.height}", style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.normal,
                  fontSize: 20),),
                  Text("Height: ${pokemon.weight}", style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.normal,
                  fontSize: 20),),
                  Text("Abilities:",textAlign: TextAlign.start, style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 22),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.abilities
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pokemon.image,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(pokemon.image))),
                )),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(capitalizeFirstCharacter((pokemon.name))),
      ),
      body: bodyWidget(context),
    );
  }
}
