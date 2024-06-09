import 'package:flutter/material.dart';
import 'package:pokedex_2/screens/pokemon_detail_screen.dart';
import 'package:provider/provider.dart';

import 'controllers/pokemon_controller.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PokemonController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PokemonListScreen(),
    );
  }
}

class PokemonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PokemonController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Pokedex')),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.errorMessage != null
          ? Center(child: Text(controller.errorMessage!))
          : ListView.builder(
        itemCount: controller.pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = controller.pokemons[index];
          return ListTile(
            leading: Image.network(pokemon.imageUrl),
            title: Text(pokemon.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetailScreen(pokemon: pokemon),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.fetchPokemons(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
