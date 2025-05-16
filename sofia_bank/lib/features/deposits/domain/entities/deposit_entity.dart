class DepositEntity {
  final String id;
  final String name;
  final double interestRate;
  final double minAmount;
  final int minTenure;
  final int maxTenure;
  final List<String> features;
  final List<String> requirements;

  const DepositEntity({
    required this.id,
    required this.name,
    required this.interestRate,
    required this.minAmount,
    required this.minTenure,
    required this.maxTenure,
    required this.features,
    required this.requirements,
  });
}
