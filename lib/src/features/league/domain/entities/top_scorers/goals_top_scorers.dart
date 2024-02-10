import 'package:equatable/equatable.dart';

class GoalsTopScorers extends Equatable {
  final int assists;
  final int total;

  GoalsTopScorers({required this.assists, required this.total});

  
  @override
  List<Object?> get props => [assists, total];
}
