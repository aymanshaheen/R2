import 'package:Goal/src/core/widgets/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_route.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../cubit/soccer_cubit.dart';
import 'fixture_card.dart';
import 'live_fixtures_card.dart';
import 'view_all_tile.dart';

class ViewDayFixtures extends StatelessWidget {
  final List<SoccerFixture> fixtures;

  const ViewDayFixtures({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.only(right: AppPadding.p20),
            child: Column(children: [
              ...List.generate(fixtures.length, (index) {
               
                /*  int nowHour = int.parse(
                    DateFormat.jm().format(DateTime.now()).split(":").first);
                bool timeIsBefore = DateTime.now().isBefore(localTime);
                int fixtureHour = int.parse(formattedTime.split(":").first);
*/
                return InkWell(
                  onTap: /*(timeIsBefore && nowHour + 1 >= fixtureHour) ||
                          fixtures[index].fixture.status.elapsed != null
                      ? */
                      () {
                    Navigator.of(context)
                        .pushNamed(Routes.fixture, arguments: fixtures[index]);
                  },
                  // : null,
                  child: FixtureCard(
                      soccerFixture: fixtures[index], isShowNextMatch: false,
                      ),
                );
              }),
            ]),
          );
  }
}

class ViewLiveFixtures extends StatelessWidget {
  final List<SoccerFixture> fixtures;

  const ViewLiveFixtures({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: AppSize.s280,
      padding: const EdgeInsets.only(right: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.stream, color: AppColors.red),
              const SizedBox(width: AppSize.s5),
              Expanded(
                child: Text(
                  AppStrings.liveFixtures,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<SoccerCubit>().changeBottomNav(1);
                  context.read<SoccerCubit>().currentFixtures = fixtures;
                },
                child: viewAll(context),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s5),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.fixture, arguments: fixtures[index]);
                },
                child: LiveFixtureCard(soccerFixture: fixtures[index]),
              ),
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSize.s10),
              itemCount: fixtures.length,
            ),
          ),
        ],
      ),
    );
  }
}
