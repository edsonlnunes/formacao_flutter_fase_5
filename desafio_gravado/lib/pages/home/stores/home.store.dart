import 'package:fase_5/models/character.model.dart';
import 'package:fase_5/services/api.service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home.store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final _apiService = ApiService();

  int _page = 1;

  @observable
  ObservableList<Character> characters = <Character>[].asObservable();

  @observable
  bool isLoading = false;

  @observable
  bool showInList = true;

  @observable
  String search = "";

  @computed
  List<Character> get filteredCharacters {
    if (search.isEmpty) return characters.toList();

    return characters
        .where((character) =>
            character.name.toLowerCase().contains(search.toLowerCase()) ||
            character.id.toString() == search)
        .toList();
  }

  @action
  void toggleShowInList() => showInList = !showInList;

  @action
  void setSearch(String s) => search = s;

  @action
  Future<void> loadData() async {
    isLoading = true;
    final result = await _apiService.getListCharacters(page: _page);
    characters.addAll(result.results);
    _page++;
    isLoading = false;
  }

  @action
  void updateCharacterColor({
    required int characterId,
    required Color backgroundColor,
    required Color textColor,
  }) {
    final index = characters.indexWhere(
      (character) => character.id == characterId,
    );
    characters[index] = characters[index].copyWith(
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}
