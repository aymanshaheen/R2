import 'package:Goal/src/core/widgets/circular_image.dart';
import 'package:Goal/src/core/widgets/circular_indicator.dart';
import 'package:Goal/src/core/widgets/responsivity.dart';
import 'package:Goal/src/features/player/domain/entities/player_info/player_stats.dart';
import 'package:Goal/src/features/player/presentation/cubit/player_cubit/player_cubit.dart';
import 'package:Goal/src/features/player/presentation/cubit/player_cubit/player_state.dart';
import 'package:Goal/src/features/player/presentation/screens/player_profile_tab.dart';
import 'package:Goal/src/features/player/presentation/screens/player_stats_tab.dart';
import 'package:Goal/src/features/player/presentation/widgets/league_service.dart';
import 'package:Goal/src/features/team/domain/entities/player_squad/player_Squad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Goal/src/core/utils/app_colors.dart';

class PlayerScreen extends StatefulWidget {
  final PlayerSquad player;
  const PlayerScreen({
    super.key,
    required this.player,
  });

  @override
  State<PlayerScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  PlayerService? playerService;
  PlayerStatsInfo? playerStatsInfo;

  @override
  void initState() {
    super.initState();
    playerService = PlayerService(
      playerCubit: context.read<PlayerCubit>(),
    );
    controller = TabController(
      length: 2,
      vsync: this,
    );
    getList();
  }

  void getList() async {
    await playerService!.getLists(player: widget.player);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerCubit, PlayerStates>(
      listener: (context, state) {
        if (state is PlayerLoaded) {
          playerStatsInfo = state.player;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              actionsIconTheme: const IconThemeData(color: AppColors.white),
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
                Container(
                  width: R.sW(context, 85),
                  margin: EdgeInsets.only(
                      right: R.sW(context, 13),
                      bottom: R.sH(context, 17),
                      top: R.sH(context, 17)),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("Follow",
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: R.F(context, 13))),
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(R.sH(context, 120)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: R.sW(context, 15)),
                      child: Row(children: [
                        CircularImageBuilder(
                            photo: widget.player.photo, height: 70, width: 100),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.player.name,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: R.F(context, 20),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: R.sH(context, 5),
                            ),
                            Text(
                              playerStatsInfo != null
                                  ? playerStatsInfo!.statisticsInfo[0].team.name
                                  : '',
                              style: TextStyle(
                                  color: AppColors.white70,
                                  fontSize: R.F(context, 14),
                                  fontWeight: FontWeight.w500),
                            ),
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
                                  horizontal: R.sW(context, 10))),
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.white70,
                          isScrollable: true,
                          indicatorWeight: R.sW(context, 3),
                          tabs: const [
                            Tab(text: "Profile"),
                            Tab(text: "Stats"),
                          ],
                        ),
                        Expanded(child: Container())
                      ],
                    )
                  ],
                ),
              )),
          body: state is PlayerLoading
              ? const CircularIndicator()
              : TabBarView(
                  controller: controller,
                  children: <Widget>[
                    PlayerOverViewTab(
                      playerStatsInfo: playerStatsInfo!,
                    ),
                    PlayerStatsTab(
                      playerStatsInfo: playerStatsInfo!,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
