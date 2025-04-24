enum CardStatus {
  active,
  blocked,
  replaced,
  deactivated;

  String get displayName {
    switch (this) {
      case CardStatus.active:
        return 'Active';
      case CardStatus.blocked:
        return 'Blocked';
      case CardStatus.replaced:
        return 'Replaced';
      case CardStatus.deactivated:
        return 'Deactivated';
    }
  }
}
