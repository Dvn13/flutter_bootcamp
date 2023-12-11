import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  const SearchWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Ara',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
