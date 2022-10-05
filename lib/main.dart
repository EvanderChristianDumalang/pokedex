import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokeApi.dart';
import 'package:pokedex/model/pokemonModel.dart';
import 'package:pokedex/screens/pokeDetails.dart';
import 'package:pokedex/utils/capitalizer.dart';


final mViewModel = PokeViewModel();

void main() {
  mViewModel.getAll(() => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Flutter Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {showSearch(context: context, delegate: PokemonSearch());},
          )
        ],
      ),
      body: GridView.count(
              crossAxisCount: 2,
              children: mViewModel.pokemons.map((pokemon)  => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      var pokeDetail = PokeDetail(
                                          pokemon: pokemon,
                                        );
                                      return pokeDetail;
                                    }));
                          },
                          child: Hero(
                            tag: pokemon.image,
                            child: Card(
                              elevation: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 150,
                                    width:150,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: NetworkImage(pokemon.image))),
                                  ),
                                  Text(
                                    capitalizeFirstCharacter(pokemon.name.toString()),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )
      );
    }
  }
  
  class PokemonSearch extends SearchDelegate<Pokemon> {
    final Pokemon? pokemon;
    
    PokemonSearch({this.pokemon});
    @override
    List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          },
        )
      ];
    }

    @override
      Widget buildLeading(BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
      
    @override
      Widget buildResults(BuildContext context) {
      return Container();
    }
    
    @override
      Widget buildSuggestions(BuildContext context) {
      final mylist = query.isEmpty?  mViewModel.pokemons 
      : mViewModel.pokemons.where((element) =>  (element.name).startsWith(RegExp(query, caseSensitive: false))).toList();
      
      return mylist.isEmpty? const Text("No Pokemon Found") : ListView.builder(
        itemCount: mylist.length,
        itemBuilder: (context, index){
          final Pokemon pokelist = mylist[index];
          return InkWell( onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>PokeDetail(pokemon:pokelist)));
          },
          child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text(capitalizeFirstCharacter(pokelist.name), style: const TextStyle(fontSize: 20),),
                ] 
              )
            ) 
          );
        }
      );
    }
  }
