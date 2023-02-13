import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_google_sign_in/package_google_sign_in.dart';

import '../../services/google_sheet_service.dart';

class GoogleSignInBloc {
  final GoogleSignInService googleSignInService;
  GoogleSignInBloc({required this.googleSignInService});
  GoogleSignInAccount? user;

  final _controllerStateUser = StreamController<GoogleSignInAccount?>();
  Stream<GoogleSignInAccount?> get streamStateUser =>
      _controllerStateUser.stream;

  void listenChangeInfoUser() {
    googleSignInService.getGoogleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {
      user = account;

      _controllerStateUser.add(account);
    });
  }

  Future<void> handleSignIn() async {
    try {
      await googleSignInService.handleSignIn();
      initGoogleApis();
    } catch (e) {
      throw "$e";
    }
  }

  void initGoogleApis() async {
    await googleSheetService.init();
  }

  void handleSignOut() {
    googleSignInService.handleSignOut();
  }

  void signInSilently() async {
    await googleSignInService.signInSilently();
  }
}
