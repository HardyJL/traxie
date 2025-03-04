import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traxie/bloc/app_data_bloc.dart';

class TraxieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TraxieAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () async {
            final bloc = context.read<AppDataBloc>();
            final state = bloc.state;
            await showDialog<void>(
              context: context,
              builder: (_) => AlertDialog.adaptive(
                content: Column(
                  children: [
                    Text(
                      'Journal Conut ${state.journalEntryModels.length} - Period Count ${state.periodModels.length}',
                    ),
                    ElevatedButton(
                      onPressed: bloc.clearTestData,
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size(double.infinity, kBottomNavigationBarHeight);
}
