import 'package:Goal/src/core/domain/entities/soccer_fixture.dart';
import 'package:Goal/src/core/widgets/responsivity.dart';
import 'package:Goal/src/features/fixture/presentation/cubit/fixture_cubit.dart';
import 'package:Goal/src/features/fixture/presentation/widgets/fixture_details.dart';
import 'package:Goal/src/features/fixture/presentation/widgets/preview-tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Goal/src/core/utils/app_colors.dart';

class MatchScreen extends StatefulWidget {
  final SoccerFixture soccerFixture;

  const MatchScreen({
    super.key,
    required this.soccerFixture,
  });

  @override
  State<MatchScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<MatchScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: tabs.length,
      vsync: this,
    );
    getlist();
  }

  getlist() async {
    FixtureCubit cubit = context.read<FixtureCubit>();
    // await cubit.getStatistics(widget.soccerFixture.fixture.id.toString());
    //await cubit.getLineups(widget.soccerFixture.fixture.id.toString());
    // await cubit.getEvents(widget.soccerFixture.fixture.id.toString());
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<Tab> tabs = const [
    Tab(text: "Facts"),
    Tab(text: "Ticker"),
    Tab(text: "Lineup"),
    Tab(text: "Table"),
    Tab(text: "Stats"),
    Tab(text: "H2H"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixtureCubit, FixtureState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is FixtureStatisticsLoading
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
                        icon: Icon(Icons.notification_add_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.star_border_outlined),
                        onPressed: () {},
                      )
                    ],
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(R.sH(context, 130)),
                        child: Column(
                          children: [
                            FixtureDetails(soccerFixture: widget.soccerFixture),
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
                              tabs: tabs,
                            )
                          ],
                        ))),
                body: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    PreviewTab(match:widget.soccerFixture),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                  ],
                ),
              );
      },
    );
  }
}
