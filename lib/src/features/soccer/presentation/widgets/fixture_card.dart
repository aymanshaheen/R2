import 'package:Goal/src/core/widgets/responsive.dart';
import 'package:Goal/src/core/widgets/responsivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../features/soccer/presentation/widgets/build_team_info.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_values.dart';

class FixtureCard extends StatelessWidget {
  final SoccerFixture soccerFixture;
  bool isShowNextMatch = false;

  FixtureCard(
      {super.key, required this.soccerFixture, required this.isShowNextMatch});

  @override
  Widget build(BuildContext context) {
    String fixtureTime = soccerFixture.fixture.date;
    final localTime = DateTime.parse(fixtureTime).toLocal();
    final formattedTime = DateFormat("h:mm a").format(localTime);
    final formattedMatchTime = DateFormat("EEE, d MMM").format(localTime);
    return Container(
      color: AppColors.darkgrey,
      margin: EdgeInsets.only(bottom: R.sH(context, 12 ),),
      child: Padding(
        padding:  EdgeInsetsDirectional.all(R.sP(context, 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isShowNextMatch)
              Padding(
                  padding:  EdgeInsets.only(bottom: R.sH(context, 10)),
                  child: Text(
                    formattedMatchTime.toString(),
                    style: TextStyle(
                        color: AppColors.white70,
                        fontSize: FontSize.paragraph,
                        fontWeight: FontWeight.w500),
                  )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TeamBuild1Info(
                  name: soccerFixture.teams.home.name,
                  logo: soccerFixture.teams.home.logo,
                ),
                (soccerFixture.fixture.status.short == "NS")
                    ? Padding(
                        padding:  EdgeInsets.symmetric(
                            horizontal: R.sW(context, 10)),
                        child: Column(
                          children: [
                            Text(
                              formattedTime.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.white70,
                                      fontSize: FontSize.paragraph),
                            ),
                          ],
                        ),
                      )
                    : (soccerFixture.goals.home != null &&
                            soccerFixture.goals.away != null)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: R.sW(context, 10)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      soccerFixture.goals.home.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColors.white70),
                                    ),
                                    Text(
                                      ":",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColors.white70),
                                    ),
                                    Text(
                                      soccerFixture.goals.away.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(color: AppColors.white70),
                                    ),
                                  ],
                                ),
                                /* const SizedBox(height: AppSize.s5),
                                if (soccerFixture.fixture.status.elapsed != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.p15,
                                      vertical: AppPadding.p5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: soccerFixture.fixture.status.short !=
                                              "FT"
                                          ? const Color.fromARGB(255, 180, 55, 55)
                                          : const Color.fromARGB(
                                              255, 124, 33, 33),
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s20),
                                    ),
                                    child: Text(
                                      soccerFixture.fixture.status.short != "FT"
                                          ? "Live"
                                          : "End",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.white,
                                              fontSize: FontSize.paragraph),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),*/
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: R.sW(context, 13),
                              vertical: AppPadding.p5,
                            ),
                            child: Text(
                              "waiting",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.white70,
                                      fontSize: FontSize.paragraph),
                              textAlign: TextAlign.center,
                            ),
                          ),
                TeamBuild2Info(
                  name: soccerFixture.teams.away.name,
                  logo: soccerFixture.teams.away.logo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
