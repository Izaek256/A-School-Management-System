import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<Widget> actions;

  const ProfileHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
              child: imageUrl.isEmpty ? Icon(Icons.person, size: 50) : null,
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ...actions,
          ],
        ),
      ),
    );
  }
}