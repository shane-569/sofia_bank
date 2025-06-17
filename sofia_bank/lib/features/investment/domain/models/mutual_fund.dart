class MutualFund {
  final String name;
  final String category;
  final double nav;
  final double returns;
  final double minimumInvestment;

  const MutualFund({
    required this.name,
    required this.category,
    required this.nav,
    required this.returns,
    required this.minimumInvestment,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MutualFund &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          category == other.category &&
          nav == other.nav &&
          returns == other.returns &&
          minimumInvestment == other.minimumInvestment;

  @override
  int get hashCode =>
      name.hashCode ^
      category.hashCode ^
      nav.hashCode ^
      returns.hashCode ^
      minimumInvestment.hashCode;
}
