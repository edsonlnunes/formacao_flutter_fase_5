import 'pokemon_stat.model.dart';

class Stat {
  final int baseStat;
  final int effort;
  final PokemonStat stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromMap(Map<String, dynamic> data) {
    return Stat(
      baseStat: data["base_stat"],
      effort: data["effort"],
      stat: PokemonStat.fromMap(data["stat"]),
    );
  }
}
