import 'package:Goal/src/core/widgets/responsivity.dart';
import 'package:Goal/src/features/soccer/domain/entities/standings.dart';
import 'package:Goal/src/features/team/domain/entities/player_squad/team_squad.dart';
import 'package:Goal/src/features/team/presentation/screens/matches_tab.dart';
import 'package:Goal/src/features/team/presentation/screens/overview_tab.dart';
import 'package:Goal/src/features/team/presentation/screens/squad_tab.dart';
import 'package:Goal/src/features/team/presentation/widgets/team_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Goal/src/core/domain/entities/soccer_fixture.dart';
import 'package:Goal/src/core/domain/entities/teams.dart';
import 'package:Goal/src/core/utils/app_colors.dart';
import 'package:Goal/src/features/team/presentation/screens/standings_tab.dart';
import 'package:Goal/src/features/team/domain/entities/statistics/statistics.dart';
import 'package:Goal/src/features/team/presentation/cubit/team_cubit/team_cubit.dart';
import 'package:Goal/src/features/team/presentation/cubit/team_cubit/team_state.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({
    super.key,
    required this.soccerFixture,
    required this.team,
  });
  final SoccerFixture soccerFixture;
  final Team team;

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  TeamStatistics? teamStatistics;
  TeamSquad? playerSquad;
  Standings? standings;
  TeamService? teamService;

  @override
  void initState() {
    super.initState();
    teamService = TeamService(teamCubit: context.read<TeamCubit>());
    controller = TabController(
      length: 4,
      vsync: this,
    );
    getList();
  }

  void getList() async {
    await teamService!
        .getLists(team: widget.team, soccerFixture: widget.soccerFixture);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit, TeamStates>(
      listener: (context, state) {
        if (state is TeamStatisticsLoaded) {
          teamStatistics = state.teamStatistics;
        }
        if (state is SoccerStandingsLoaded) {
          standings = state.standings;
        }
        if (state is PlayerSquadLoaded) {
          playerSquad = state.teamSquad;
        }
      },
      builder: (context, state) {
        return state is TeamStatisticsLoading
            ? const CupertinoActivityIndicator()
            : Scaffold(
                appBar: AppBar(
                    actionsIconTheme:
                        const IconThemeData(color: AppColors.white),
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.white,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notification_add_outlined),
                      ),
                      Container(
                        width: R.sW(context, 85),
                        margin:  EdgeInsets.only(
                            right: R.sW(context, 13), bottom: R.sH(context, 17), top: R.sH(context, 17)),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  Center(
                          child: Text("Follow",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: R.F(context, 13))),
                        ),
                      )
                    ],
                    bottom: PreferredSize(
                      preferredSize:  Size.fromHeight(R.sH(context, 100)),
                      child: teamStatistics != null
                          ? Column(
                              children: [
                                Padding(
                                  padding:
                                       EdgeInsets.only(left: R.sW(context, 20)),
                                  child: Row(children: [
                                    Container(
                                      width: R.sW(context, 90),
                                      height: R.sH(context, 50),
                                      child: Center(
                                        child: Image.network(
                                          teamStatistics!.team!.logo,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          teamStatistics!.team!.name,
                                          style:  TextStyle(
                                              color: AppColors.white,
                                              fontSize: R.F(context, 20),
                                              fontWeight: FontWeight.w600),
                                        ),
                                         SizedBox(
                                          height: R.sH(context, 5),
                                        ),
                                        Text(
                                            teamStatistics!.league!.name
                                                .toString(),
                                            style: const TextStyle(
                                                color: AppColors.white70)),
                                      ],
                                    )
                                  ]),
                                ),
                                Row(
                                  children: [
                                    TabBar(
                                      controller: controller,
                                      indicator: UnderlineTabIndicator(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          borderSide: BorderSide(
                                            width: R.sW(context, 3),
                                            color: AppColors.green,
                                          ),
                                          insets: EdgeInsets.symmetric(
                                              horizontal: R.sH(context, 10))),
                                      labelColor: AppColors.white,
                                      unselectedLabelColor: AppColors.white70,
                                      isScrollable: true,
                                      indicatorWeight: R.sW(context, 3),
                                      tabs: const [
                                        Tab(text: "Overview"),
                                        Tab(text: "Matches"),
                                        Tab(text: "Table"),
                                        Tab(text: "Squad"),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                  ],
                                )
                              ],
                            )
                          : Container(),
                    )),
                body: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    teamService!.nextMatch.isNotEmpty
                        ? OverViewTab(
                            standings: standings,
                            match: widget.soccerFixture,
                            team: widget.team,
                            lastMatches: teamService!.lastMatches,
                            teamStatistics: teamStatistics!,
                          )
                        : Container(),
                    teamService!.lastMatches.isNotEmpty &&
                            teamService!.nextMatches.isNotEmpty
                        ? MatchesTab(
                            nextMatches: teamService!.nextMatches,
                            lastMatches: teamService!.lastMatches,
                          )
                        : Container(),
                   standings!=null? StandingsScreen(
                      standings: standings,
                      team: widget.team,
                    ):Container(),
                    playerSquad != null
                        ? PlayerSquadTab(teamSquad: playerSquad!)
                        : Container(),
                  ],
                ),
              );
      },
    );
  }
}
