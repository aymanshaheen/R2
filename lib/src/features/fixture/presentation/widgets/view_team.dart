import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/entities/teams.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/widgets/responsivity.dart';

class ViewTeam extends StatelessWidget {
  final Team team;

  const ViewTeam({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          width: R.sW(context, 45),
          height: R.sH(context, 45),
          imageUrl: team.logo,
        ),
        SizedBox(height: R.sH(context, 7)),
        FittedBox(
          child: Text(
            team.name.split(" ").length >= 3
                ? team.name.split(" ").sublist(0, 2).join(" ")
                : team.name,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
