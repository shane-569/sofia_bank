import 'package:flutter/material.dart';
import 'package:sofia_bank/features/investment/domain/models/recipient.dart';

class RecipientListItem extends StatelessWidget {
  final Recipient recipient;
  final VoidCallback onTap;

  const RecipientListItem({
    Key? key,
    required this.recipient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: recipient.imageUrl != null
                  ? NetworkImage(recipient.imageUrl!)
                  : null, // Placeholder or default image if no URL
              child: recipient.imageUrl == null
                  ? Icon(Icons.person, color: Colors.grey[600])
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipient.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipient.address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
