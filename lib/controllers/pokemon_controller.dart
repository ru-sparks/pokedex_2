import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonController with ChangeNotifier {
  List<Pokemon> _pokemons = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Pokemon> get pokemons => _pokemons;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final PokemonService _service = PokemonService();

  Future<void> fetchPokemons() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pokemons = await _service.fetchPokemons();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
