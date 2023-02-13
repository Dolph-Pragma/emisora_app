import 'package:emisora_flutter_app/bloc/bloc_sign_in/google_sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:package_google_sign_in/package_google_sign_in.dart';

import '../../google_sheet/show_users_google_sheet_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final bloc =
      GoogleSignInBloc(googleSignInService: GoogleSignInService());

  @override
  void initState() {
    super.initState();
    bloc.streamStateUser.listen((event) {
      if (event!.email.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 850),
              transitionsBuilder: (_, animation, __, child) {
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticOut,
                  ),
                  child: child,
                );
              },
              pageBuilder: (_, animation, __) {
                return const ShowUsersGoogleSheetScreen();
              }),
        );
      }
    });
    bloc.listenChangeInfoUser();
    bloc.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Text('You are not currently signed in.'),
        ElevatedButton(
          onPressed: bloc.handleSignIn,
          child: const Text('SIGN IN'),
        ),
      ],
    );
  }
}
