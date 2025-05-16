class UserDepositEntity {
  final String id;
  final String depositId;
  final String depositName;
  final double amount;
  final double interestRate;
  final int tenure;
  final DateTime startDate;
  final DateTime maturityDate;
  final double maturityAmount;
  final String status; // 'active', 'matured', 'closed'

  const UserDepositEntity({
    required this.id,
    required this.depositId,
    required this.depositName,
    required this.amount,
    required this.interestRate,
    required this.tenure,
    required this.startDate,
    required this.maturityDate,
    required this.maturityAmount,
    required this.status,
  });
}
