import 'package:crypto_polygon/src/features/crypto_list_screen/ui/crypto_list_screen.dart';
import 'package:crypto_polygon/src/features/dependencies_provider/dependency_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DependenciesProvider(
      builder: (BuildContext context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: CryptoScreen(),
        );
      },
    ),
  );
}
