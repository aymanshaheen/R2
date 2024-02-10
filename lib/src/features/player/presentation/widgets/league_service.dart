import 'package:Goal/src/features/player/presentation/cubit/player_cubit/player_cubit.dart';
import 'package:Goal/src/features/player/domain/use_case/player_info_use_case.dart';
import 'package:Goal/src/features/team/domain/entities/player_squad/player_Squad.dart';

class PlayerService {
  final PlayerCubit playerCubit;

  PlayerService({required this.playerCubit});

  Future<void> getLists({required PlayerSquad player}) async {
    PlayerParams playerParams =
        PlayerParams(playerId: player.id.toString(), season: "2023");
    await playerCubit.getPlayerInfo(playerParams);
  }
}
