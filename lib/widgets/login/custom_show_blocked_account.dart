import 'package:flutter/material.dart';

class CustomShowBlockedAccount extends StatelessWidget {
  final int attempts;
  const CustomShowBlockedAccount({
    super.key,
    required this.attempts,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          attempts >= 3 && attempts < 5
              ? '${5 - attempts} tentativas restantes'
              : attempts == 5
                  ? 'Usuário Bloqueado'
                  : '',
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
