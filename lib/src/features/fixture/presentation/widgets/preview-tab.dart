import 'package:Goal/src/core/domain/entities/soccer_fixture.dart';
import 'package:Goal/src/core/domain/entities/teams.dart';
import 'package:Goal/src/core/utils/app_colors.dart';
import 'package:Goal/src/core/widgets/responsive.dart';
import 'package:Goal/src/core/widgets/responsivity.dart';
import 'package:Goal/src/features/fixture/presentation/cubit/fixture_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewTab extends StatelessWidget {
  final SoccerFixture match;
  PreviewTab({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FixtureCubit, FixtureState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(R.sW(context, 10)),
            child: Column(
              children: [
                Container(
                  height: R.sH(context, 200),
                  width: R.W(context),
                  decoration: BoxDecoration(
                    color: AppColors.darkgrey,
                    borderRadius: BorderRadius.circular(R.sW(context, 10)),
                  ),
                  padding: EdgeInsets.all(R.sW(context, 10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: R.sH(context, 30),
                            width: R.sW(context, 30),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(R.sW(context, 10)),
                              image: DecorationImage(
                                image: NetworkImage(match.fixtureLeague.logo),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: R.sW(context, 30)),
                          Text(
                            match.fixtureLeague.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: R.sW(context, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: R.sH(context, 10)),
                      Row(
                        children: [
                          Container(
                            height: R.sH(context, 30),
                            width: R.sW(context, 30),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(R.sW(context, 10)),
                              image: DecorationImage(
                                image: NetworkImage(match.fixtureLeague.logo),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: R.sW(context, 30)),
                          Text(
                        match.fixtureLeague.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: R.sW(context, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: R.sH(context, 10)),Row(
                        children: [
                          Container(
                            height: R.sH(context, 30),
                            width: R.sW(context, 30),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(R.sW(context, 10)),
                              image: DecorationImage(
                                image: NetworkImage(match.fixtureLeague.logo),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: R.sW(context, 30)),
                          Text(
                            match.fixtureLeague.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: R.sW(context, 14),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: R.sH(context, 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
