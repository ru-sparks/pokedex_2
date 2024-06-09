import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';


class PokemonService {
  // The hard-coded query limit is a bad idea.
  //  This is an area that needs improvement.
  //  The user's first view takes a long time.
  static const String apiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=1010';

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['results'];
      List<Pokemon> pokemons = [];
      int count = 0;
     // var next = await http.get(Uri.parse(item['next']));
      for (var item in data) {
        final detailResponse = await http.get(Uri.parse(item['url']));

        if (detailResponse.statusCode == 200) {
          print("${count++}  ${jsonDecode(detailResponse.body)}");
          pokemons.add(Pokemon.fromJson(jsonDecode(detailResponse.body)));
        }
      }
      return pokemons;
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}
