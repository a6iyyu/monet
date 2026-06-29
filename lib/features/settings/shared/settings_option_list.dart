import 'package:flutter/material.dart';
import 'package:monet/features/settings/models/settings_option.dart';

class SettingsOptionList extends StatelessWidget {
  final String sectionTitle;
  final List<SettingsOption> options;

  const SettingsOptionList({ super.key, required this.sectionTitle, required this.options });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 24.0, bottom: 8.0),
          child: Text(
            sectionTitle.toUpperCase(),
            style: TextStyle(
              color: Colors.blueGrey.shade400,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withValues(alpha: 0.03),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.separated(
            itemCount: options.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.shade200,
              endIndent: 16,
              height: 1,
              indent: 56,
            ),
            itemBuilder: (context, index) {
              final item = options[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: (item.iconColor ?? Colors.blue).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: item.iconColor ?? Colors.blue,
                    size: 22,
                  ),
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                subtitle: item.subtitle != null
                  ? Text(item.subtitle!, style: TextStyle(color: Colors.grey.shade500, fontSize: 13))
                  : null,
                trailing: item.trailing ?? Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400, size: 16),
                onTap: item.onTap,
              );
            },
          ),
        ),
      ],
    );
  }
}