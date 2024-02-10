import 'dart:math';
import 'package:Goal/src/core/utils/app_colors.dart';
import 'package:Goal/src/core/utils/app_size.dart';
import 'package:Goal/src/core/widgets/responsivity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TeamBuild1Info extends StatelessWidget {
  final String logo;
  final String name;

  const TeamBuild1Info({required this.logo, required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name.substring(0, min(16, name.length)),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeights.medium,
                fontSize: R.F(context, 11),
                color: AppColors.white),
          ),
          SizedBox(width: R.sW(context,5)),
          CachedNetworkImage(
            fit: BoxFit.cover,
            height: R.sH(context, 25),
            width: R.sW(context, 25),
            imageUrl: logo,
          ),
        ],
      ),
    );
  }
}
class TeamBuild2Info extends StatelessWidget {
  final String logo;
  final String name;

  const TeamBuild2Info({required this.logo, required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            height: R.sH(context, 25),
            width: R.sW(context, 25),
            imageUrl: logo,
          ),
                     SizedBox(width: R.sW(context, 5)),

          Text(
            name.substring(0, min(16, name.length)),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeights.medium,
                fontSize: R.F(context, 11),
                color: AppColors.white),
          ),
         
        ],
      ),
    );
  }
}