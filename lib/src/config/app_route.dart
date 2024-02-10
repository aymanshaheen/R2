import 'package:Goal/src/core/domain/entities/league.dart';
import 'package:Goal/src/core/widgets/page_transition.dart';
import 'package:Goal/src/features/fixture/presentation/screens/match_screen.dart';
import 'package:Goal/src/features/league/presentation/cubit/league_cubit/league_cubit.dart';
import 'package:Goal/src/features/league/presentation/screens/league_screen.dart';
import 'package:Goal/src/features/player/presentation/cubit/player_cubit/player_cubit.dart';
import 'package:Goal/src/features/player/presentation/screens/player_screen.dart';
import 'package:Goal/src/features/soccer/presentation/screens/leagues_screen.dart';
import 'package:Goal/src/features/spalsh_screen.dart';
import 'package:Goal/src/features/team/domain/entities/player_squad/player_Squad.dart';
import 'package:Goal/src/features/team/domain/use_cases/player_squad_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Goal/src/features/soccer/domain/use_cases/standings_usecase.dart';
import 'package:Goal/src/features/team/domain/use_cases/last_matches_use_case.dart';
import 'package:Goal/src/features/team/domain/use_cases/next_match_use_case.dart';
import 'package:Goal/src/features/team/domain/use_cases/statistics_use_case.dart';
import 'package:Goal/src/features/team/presentation/cubit/team_cubit/team_cubit.dart';
import 'package:Goal/src/features/team/presentation/screens/team_screen.dart';
import '../container_injector.dart';
import '../core/domain/entities/soccer_fixture.dart';
import '../core/utils/app_strings.dart';
import '../features/fixture/domain/use_cases/events_usecase.dart';
import '../features/fixture/domain/use_cases/lineups_usecase.dart';
import '../features/fixture/domain/use_cases/statistics_usecase.dart';
import '../features/fixture/presentation/cubit/fixture_cubit.dart';
import '../features/fixture/presentation/screens/fixture_screen.dart';
import '../features/soccer/presentation/cubit/soccer_cubit.dart';
import '../features/soccer/presentation/screens/fixtures_screen.dart';
import '../features/soccer/presentation/screens/soccer_layout.dart';
import '../features/soccer/presentation/screens/soccer_screen.dart';

class Routes {
  static const String soccerLayout = "soccerLayout";
  static const String soccer = "soccer";
  static const String fixtures = "fixtures";
  static const String leagues = "leagues";
  static const String league = "league";
  static const String fixture = "fixture";
  static const String team = "team";
  static const String splash = "splash";
  static const String player = "player";
}

class AppRouter {
  static Route routesGenerator(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
         case Routes.soccerLayout:
        return FadeRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SoccerCubit>(),
            child: const SoccerLayout(),
          ),
        );
      case Routes.soccer:
        return FadeRoute(
          builder: (context) => BlocProvider.value(
            value: sl<SoccerCubit>(),
            child: const SoccerScreen(),
          ),
        );
      case Routes.fixtures:
        return FadeRoute(
          builder: (context) => BlocProvider.value(
            value: sl<SoccerCubit>(),
            child: const FixturesScreen(),
          ),
        );
      case Routes.fixture:
        return FadeRoute(
          builder: (context) {
            SoccerFixture soccerFixture = settings.arguments as SoccerFixture;
            return BlocProvider(
              create: (context) => sl<FixtureCubit>()
                ..getStatistics(soccerFixture.fixture.id.toString()),
              child: MatchScreen(soccerFixture: soccerFixture),
            );
          },
        );
      case Routes.player:
        return FadeRoute(
          builder: (context) {
            PlayerSquad player = settings.arguments as PlayerSquad;
            return BlocProvider.value(
              value: sl<PlayerCubit>(),
              child: PlayerScreen(
                player: player,
              ),
            );
          },
        );
      case Routes.leagues:
        return FadeRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => sl<SoccerCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<LeagueInfoCubit>(),
            ),
          ], child: const AllLeaguesScreen()),
        );
      case Routes.team:
        return FadeRoute(builder: (context) {
          List<dynamic> args = settings.arguments as List<dynamic>;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<TeamCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<PlayerCubit>(),
              )
            ],
            child: TeamScreen(
              soccerFixture: args[0],
              team: args[1],
            ),
          );
        });
      case Routes.league:
        return FadeRoute(builder: (context) {
          League league = settings.arguments as League;
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: sl<LeagueInfoCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<TeamCubit>(),
              ),
            ],
            child: LeagueInfoScreen(
              league: league,
            ),
          );
        });
    }

    return MaterialPageRoute(builder: (context) => const NoRouteFound());
  }
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text(AppStrings.noRouteFound)),
      );
}
