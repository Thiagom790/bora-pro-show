import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_bora_show/core/app.auth.dart';
import 'package:tcc_bora_show/store/auth.store.dart';
import 'package:tcc_bora_show/store/profile.store.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthStore>(create: (_) => AuthStore()),
        Provider<ProfileStore>(create: (_) => ProfileStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppAuth(),
      ),
    );
  }
}