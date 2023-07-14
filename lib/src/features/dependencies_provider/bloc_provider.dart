import 'package:crypto_polygon/src/features/crypto_detailed_screen/data/bloc/crypto_detailed_bloc.dart';
import 'package:crypto_polygon/src/features/crypto_detailed_screen/data/repo/repo.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/data/bloc/crypto_list_bloc.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/data/repo/repo.dart';
import 'package:crypto_polygon/src/features/search_screen/data/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search_screen/data/bloc/search_bloc.dart';

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CryptoListBloc(
            repo: RepositoryProvider.of<RepoCryptoList>(context),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            repo: RepositoryProvider.of<RepoSearch>(context),
          ),
        ),
        BlocProvider(
          create: (context) => CryptoDetailedBloc(
            repo: RepositoryProvider.of<RepoCryptoDetailed>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}