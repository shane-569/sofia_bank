import 'package:dartz/dartz.dart';
import 'package:sofia_bank/features/investment/domain/models/mutual_fund.dart';
import 'package:sofia_bank/features/investment/domain/repositories/mutual_fund_repository.dart';

class MutualFundRepositoryImpl implements MutualFundRepository {
  final List<MutualFund> _dummyData = [
    const MutualFund(
      name: 'ICICI Prudential Technology Fund',
      category: 'Equity',
      nav: 45.67,
      returns: 12.5,
      minimumInvestment: 5000,
    ),
    const MutualFund(
      name: 'HDFC Top 100 Fund',
      category: 'Equity',
      nav: 78.90,
      returns: 15.2,
      minimumInvestment: 5000,
    ),
    const MutualFund(
      name: 'Axis Bluechip Fund',
      category: 'Equity',
      nav: 65.43,
      returns: 14.8,
      minimumInvestment: 5000,
    ),
    const MutualFund(
      name: 'SBI Magnum Gilt Fund',
      category: 'Debt',
      nav: 32.15,
      returns: 8.5,
      minimumInvestment: 5000,
    ),
    const MutualFund(
      name: 'ICICI Prudential Balanced Fund',
      category: 'Hybrid',
      nav: 55.78,
      returns: 11.2,
      minimumInvestment: 5000,
    ),
  ];

  @override
  Future<Either<String, List<MutualFund>>> getMutualFunds() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      return Right(_dummyData);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MutualFund>>> getMutualFundsByCategory(
      String category) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      if (category == 'All') {
        return Right(_dummyData);
      }
      final filteredFunds =
          _dummyData.where((fund) => fund.category == category).toList();
      return Right(filteredFunds);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
