import 'package:dartz/dartz.dart';
import 'package:sofia_bank/features/investment/domain/models/mutual_fund.dart';

abstract class MutualFundRepository {
  Future<Either<String, List<MutualFund>>> getMutualFunds();
  Future<Either<String, List<MutualFund>>> getMutualFundsByCategory(
      String category);
}
