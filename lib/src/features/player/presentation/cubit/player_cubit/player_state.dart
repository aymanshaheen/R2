import 'package:Goal/src/features/player/domain/entities/player_info/player_stats.dart';

abstract class PlayerStates {}

class PlayerInitial extends PlayerStates {}

class PlayerLoading extends PlayerStates {}

class PlayerLoaded extends PlayerStates {
  final PlayerStatsInfo player;

  PlayerLoaded(this.player);
}
class PlayerLoadedError extends PlayerStates {
  final String message;

  PlayerLoadedError(this.message);
}

