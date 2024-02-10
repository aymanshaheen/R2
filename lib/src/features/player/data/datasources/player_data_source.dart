import 'package:Goal/src/core/api/dio_helper.dart';
import 'package:Goal/src/core/api/endpoints.dart';
import 'package:Goal/src/features/player/data/models/player_statistics/player_stats_model.dart';
import 'package:Goal/src/features/player/domain/use_case/player_info_use_case.dart';

abstract class PlayerDataSource {
    Future<PlayerStatsModelInfo> getPlayerInfo({required PlayerParams params});
}

class PlayerDataSourceImpl implements PlayerDataSource {
  final DioHelper dioHelper;

  PlayerDataSourceImpl({required this.dioHelper});
  
  @override
  Future<PlayerStatsModelInfo> getPlayerInfo({required PlayerParams params}) async {
   try {
      final response = await dioHelper.get(
          url: Endpoints.player, queryParams: params.toJson());
      Map<String, dynamic> result = response.data["response"][0];
      PlayerStatsModelInfo statistics = PlayerStatsModelInfo.fromJson(result);
      return statistics;
    } catch (error) {
      rethrow;
    }
  }

}

