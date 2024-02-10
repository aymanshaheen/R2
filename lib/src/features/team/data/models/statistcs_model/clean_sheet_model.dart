import 'package:Goal/src/features/team/domain/entities/statistics/clean_sheet.dart';

class CleanSheetModel extends CleanSheet {
  CleanSheetModel({
    required super.away,
    required super.home,
    required super.total,
  });

 

  factory CleanSheetModel.fromJson(Map<String, dynamic> json) {
    return CleanSheetModel(
      away: json["away"],
      home: json["home"],
      total: json["total"],
    );
  }
}
