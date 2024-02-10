import 'package:Goal/src/features/league/domain/entities/top_scorers/league_top_scorers.dart';
import 'package:Goal/src/features/league/domain/repositories/league_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';

class TopYellowCardsUseCase implements UseCase<List<PlayerTopScorers>, YellowParams> {
  final LeagueRepository leagueRepository;

  TopYellowCardsUseCase({required this.leagueRepository});

  @override
  Future<Either<Failure, List<PlayerTopScorers>>> call(YellowParams league) async {
    return await leagueRepository.getYellowCards(league: league);
    
  }
}
class YellowParams extends Equatable {
   final int leagueId;
  final int season;

  const YellowParams({required this.leagueId,required this.season});

  @override
  List<Object?> get props => [season, leagueId];

  Map<String, dynamic> toJson() => {"season": season, "league": leagueId};
}


