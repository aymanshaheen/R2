import 'package:Goal/src/core/utils/app_constants.dart';
import 'package:Goal/src/core/widgets/circular_indicator.dart';
import 'package:Goal/src/core/widgets/media_query.dart';
import 'package:Goal/src/core/widgets/responsivity.dart';
import 'package:Goal/src/features/soccer/presentation/widgets/no_fixtures_today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/view_fixtures.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';

class SoccerScreen extends StatefulWidget {
  const SoccerScreen({super.key});

  @override
  State<SoccerScreen> createState() => _SoccerScreenState();
}

class _SoccerScreenState extends State<SoccerScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<DateTime> dates = List<DateTime>.generate(
      30, (i) => DateTime.now().subtract(Duration(days: 15 - i)));
  List<SoccerFixture> fixtures = [];
  List<SoccerFixture> liveFixtures = [];

  @override
  void initState() {
    super.initState();
    getLists();
    int initialIndex =
        dates.indexWhere((date) => date.day == DateTime.now().day);
    _tabController = TabController(
        length: dates.length, vsync: this, initialIndex: initialIndex);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      // Scroll to the selected tab.
      _scrollToSelectedTab();
    }
    getFixtures(dates[_tabController!.index]);
  }

  void _scrollToSelectedTab() {
    double tabScrollPosition = 0.0;
    for (int i = 0; i < _tabController!.index; i++) {
      tabScrollPosition += 1.0;
    }
    _tabController!.animateTo(tabScrollPosition.round());
  }

  getFixtures(DateTime date) async {
    SoccerCubit cubit = context.read<SoccerCubit>();
    fixtures = await cubit.getFixtures(DateFormat("yyyy-MM-dd").format(date));
    setState(() {});
  }

  getLists() async {
    SoccerCubit cubit = context.read<SoccerCubit>();

    /* if (cubit.filteredLeagues.isNotEmpty) {
      await cubit.getLiveFixtures().then((value) {
        cubit.currentFixtures = liveFixtures = value;
      });
    }*/
    if (cubit.filteredLeagues.isEmpty) {
      await cubit.getLeagues();
    }
    if (cubit.filteredLeagues.isNotEmpty && fixtures.isEmpty) {
      _handleTabSelection();
    }
    
  }

  @override
  void dispose() {
    _tabController!.removeListener(_handleTabSelection);
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoccerCubit, SoccerStates>(
      listener: (context, state) {   
      },
      builder: (context, state) {
        SoccerCubit cubit = context.read<SoccerCubit>();
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              AppStrings.footballista,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              Row(children: [
                const Icon(Icons.live_tv, color: AppColors.white70),
                SizedBox(width: R.sW(context, 20)),
                const Icon(Icons.search, color: AppColors.white70),
                SizedBox(width: R.sW(context, 10)),
              ])
            ],
            bottom: TabBar(
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(R.sR(context, 10)),
                      topRight: Radius.circular(R.sR(context, 10))),
                  borderSide: BorderSide(
                    color: AppColors.green,
                    width: R.sW(context, 3),
                  ),
                  insets: EdgeInsets.symmetric(horizontal: R.sH(context, 10))),
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.white70,
              isScrollable: true,
              indicatorWeight: R.sW(context, 3),
              tabs: dates
                  .map(
                      (date) => Tab(text: DateFormat('EEE d MMM').format(date)))
                  .toList(),
            ),
          ),
          body: state is SoccerFixturesLoading||state is SoccerLeaguesLoading
              ? const CircularIndicator()
              : TabBarView(
                  controller: _tabController,
                  children: dates.map((date) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getLiveFixtures();
                        _handleTabSelection();
                      },
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top: R.sH(context, 10)),
                          child: Column(
                            children: fixtures.isNotEmpty
                                ? List.generate(AppConstants.leaguesList.length,
                                    (index) {
                                    bool isTaped = AppConstants
                                        .leaguesFixtures[
                                            AppConstants.leaguesList[index]]!
                                        .league
                                        .isTapped;
                                    return Column(
                                      children: [
                                        AnimatedSize(
                                          alignment: Alignment.topCenter,
                                          duration: Duration(milliseconds: 600),
                                          curve: Curves.linear,
                                          child: Container(
                                            padding:  EdgeInsets.only(
                                              right: R.sH(context, 10),
                                              left: R.sH(context, 10),
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: R.sH(context, 10)),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      R.sR(context, 10)),
                                              color: AppColors.darkgrey,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: R.sH(context,40) ,
                                                  padding:
                                                      EdgeInsets.only(top: R.sH(context, 5), bottom: R.sH(context, 5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.network(
                                                            AppConstants
                                                                .leaguesFixtures[
                                                                    AppConstants
                                                                            .leaguesList[
                                                                        index]]!
                                                                .league
                                                                .logo,
                                                            height:
                                                               R.sH(context, 25),
                                                            width:
                                                               R.sH(context, 25)
                                                          ),
                                                          SizedBox(
                                                              width: R.sW(context, 5)),
                                                          Text(
                                                            AppConstants
                                                                .leaguesFixtures[
                                                                    AppConstants
                                                                            .leaguesList[
                                                                        index]]!
                                                                .league
                                                                .name,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: R.F(context, 14)
                                                                  ,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            AppConstants
                                                                    .leaguesFixtures[
                                                                        AppConstants.leaguesList[
                                                                            index]]!
                                                                    .league
                                                                    .isTapped =
                                                                !AppConstants
                                                                    .leaguesFixtures[
                                                                        AppConstants
                                                                            .leaguesList[index]]!
                                                                    .league
                                                                    .isTapped;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          isTaped
                                                              ? Icons
                                                                  .keyboard_arrow_up
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                          color:
                                                              AppColors.white,
                                                          size: R.F(context, 22),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (isTaped) ...[
                                                  const Divider(
                                                    color: AppColors.black,
                                                    thickness: 1,
                                                  ),
                                                  ViewDayFixtures(
                                                      fixtures: AppConstants
                                                          .leaguesFixtures[
                                                              AppConstants
                                                                      .leaguesList[
                                                                  index]]!
                                                          .fixtures),
                                                ],
                                                SizedBox(
                                                  height: R.sH(context, 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: R.sH(context, 10)
                                        ),
                                      ],
                                    );
                                  })
                                : [
                                    SizedBox(
                                        height: context.height / 2,
                                        child: const NoFixturesToday())
                                  ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        );
      },
    );
  }
}


Gradient getGradientColor(SoccerFixture fixture) {
  Gradient color = AppColors.blueGradient;
  if (fixture.goals.away != fixture.goals.home) {
    color = AppColors.redGradient;
  }
  return color;
}
