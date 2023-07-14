import 'package:crypto_polygon/src/features/crypto_detailed_screen/data/repo/repo.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/data/repo/repo.dart';
import 'package:crypto_polygon/src/features/search_screen/data/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../api/api.dart';

class ReposProvider extends StatelessWidget {
  const ReposProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Api(),
        ),
        Provider(
            create: (context) => RepoCryptoList(
                  api: RepositoryProvider.of<Api>(context),
                )),
        Provider(
            create: (context) => RepoSearch(
              api: RepositoryProvider.of<Api>(context),
            )),
        Provider(
            create: (context) => RepoCryptoDetailed(
              api: RepositoryProvider.of<Api>(context),
            )),
      ],
      child: child,
    );
  }
}
