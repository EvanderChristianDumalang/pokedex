// ignore_for_file: avoid_print, dead_code

import 'package:dio/dio.dart';
import 'package:pokedex/model/pokemonModel.dart';

var dio = Dio(
    BaseOptions(baseUrl: "https://pokeapi.co/api/v2/", connectTimeout: 10000));

class PokeApi {
  Future<List<Pokemon>> getAll() async {
    List<Pokemon> pokemons = [];

    Response response;
    Response responses = await dio.get("pokemon?offset=0&limit=151");
    //ganti saja ke 151, menggunakan 10 pokemon agar cepat untuk loading
    for (var result in responses.data['results']) {
      response = await dio.get(result['url']);
      pokemons.add(Pokemon.fromJson(response.data));

    }
    return pokemons;
  }
}

class PokeViewModel {
  final _api = PokeApi();

  late List<Pokemon> pokemons;

  void getAll(Function onLoaded) {
    _api.getAll().then((r) {
      pokemons = r;

      onLoaded();
    }).catchError((e) {
      print(e);
    });
  }
}
