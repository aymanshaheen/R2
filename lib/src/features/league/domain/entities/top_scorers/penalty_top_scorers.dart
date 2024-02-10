import 'package:equatable/equatable.dart';

class PenaltyTopScorers extends Equatable {
  final int scored;

  PenaltyTopScorers({required this.scored});

  
  @override
  List<Object?> get props => [scored];
}