import 'package:Goal/src/features/team/domain/entities/player_squad/player_Squad.dart';
import 'package:Goal/src/features/team/domain/use_cases/player_squad_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Goal/src/core/domain/entities/soccer_fixture.dart';
import 'package:Goal/src/core/utils/app_constants.dart';
import 'package:Goal/src/features/soccer/domain/use_cases/standings_usecase.dart';
import 'package:Goal/src/features/team/domain/use_cases/last_matches_use_case.dart';
import 'package:Goal/src/features/team/domain/use_cases/next_match_use_case.dart';
import 'package:Goal/src/features/team/domain/use_cases/statistics_use_case.dart';
import 'team_state.dart';

class TeamCubit extends Cubit<TeamStates> {
  final StatisticsUseCase teamUseCase;
  final LastMatchesUseCase lastMatchesUseCase;
  final NextMatchesUseCase nextMatchesUseCase;
  final StandingsUseCase standingUseCase;
  final PlayerSquadUseCase playerSquadUseCase;

  TeamCubit( {required this.playerSquadUseCase,
    required this.standingUseCase,
    required this.nextMatchesUseCase,
    required this.lastMatchesUseCase,
    required this.teamUseCase,
  }) : super(TeamInitial());

  Future<void> getStatistics(StatisticsParams params) async {
    emit(TeamStatisticsLoading());
    final satatistics = await teamUseCase(params);
    satatistics.fold(
      (left) => emit(TeamStatisticsLoadFailure(left.message)),
      (right) {
        emit(TeamStatisticsLoaded(right));
      },
    );
  }

  Future<List<SoccerFixture>> getLastMatches(LastMatchesParams params) async {
    emit(LastMatchesLoading());
    final fixtures = await lastMatchesUseCase(params);
    List<SoccerFixture> filteredFixtures = [];
    fixtures.fold(
      (left) => emit(LastMatchesLoadFailure(left.message)),
      (right) {
        for (SoccerFixture match in right) {
          if (AppConstants.availableLeagues.contains(match.fixtureLeague.id)) {
            filteredFixtures.add(match);
          }
        }
        emit(LastMatchesLoaded(filteredFixtures));
      },
    );
    return filteredFixtures;
  }

  Future<List<SoccerFixture>> getNextMatches(NextMatchesParams params) async {
    emit(NextMatchesLoading());
    final fixtures = await nextMatchesUseCase(params);
    List<SoccerFixture> filteredFixtures = [];
    fixtures.fold(
      (left) => emit(NextMatchesLoadFailure(left.message)),
      (right) {
        for (SoccerFixture match in right) {
          if (AppConstants.availableLeagues.contains(match.fixtureLeague.id)) {
            filteredFixtures.add(match);
          }
        }
        emit(NextMatchesLoaded(filteredFixtures));
      },
    );
    return filteredFixtures;
  }

  Future<void> getStandings(StandingsParams params) async {
    emit(SoccerStandingsLoading());
    final standings = await standingUseCase(params);
    standings.fold(
      (left) => emit(SoccerStandingsLoadFailure(left.message)),
      (right) {
        emit(SoccerStandingsLoaded(right));
      },
    );
  }
  Future<void> getPlayerSquad(int teamId) async {
    emit(PlayerSquadLoading());
    final squads = await playerSquadUseCase(teamId);
    squads.fold(
      (left) => emit(PlayerSquadLoadFailure(left.message)),
      (right) {
       emit(PlayerSquadLoaded(right)); 
        }
    );
  }
}
