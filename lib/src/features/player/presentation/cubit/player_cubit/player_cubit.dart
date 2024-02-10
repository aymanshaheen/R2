import 'package:Goal/src/features/player/domain/use_case/player_info_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'player_state.dart';

class PlayerCubit extends Cubit<PlayerStates> {
  final PlayerInfoUseCase playerUseCase;
  PlayerCubit({required this.playerUseCase}) : super(PlayerInitial());

   Future<void> getPlayerInfo(PlayerParams params) async {
    emit(PlayerLoading());
    final player = await playerUseCase(params);
    player.fold(
      (left) => emit(PlayerLoadedError(left.message)),
      (right) {
        emit(PlayerLoaded(right));
      },
    );
  }
}
