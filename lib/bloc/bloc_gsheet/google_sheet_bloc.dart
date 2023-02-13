import 'dart:async';

import '../../models/user_model.dart';
import '../../services/google_sheet_service.dart';

GoogleSheetBloc googleSheetBloc = GoogleSheetBloc(
  googleSheetService: googleSheetService,
);

/// Class for getting and deleting users in a user list
class GoogleSheetBloc {
  GoogleSheetBloc({
    required this.googleSheetService,
  });

  final GoogleSheetService googleSheetService;

  /// Stream for control the list of users
  final _controllerListUser = StreamController<List<User>>.broadcast();
  Stream<List<User>> get streamListUser => _controllerListUser.stream;

  /// Stream for control when user was deleted
  final _controllerDeleteUser = StreamController<bool>();
  Stream<bool> get streamDeleteUser => _controllerDeleteUser.stream;

  ///Function for getting all users
  Future<void> getAllUsers() async {
    List<User>? listUsers = await googleSheetService.getAllUser();
    _controllerListUser.add(listUsers!);
  }

  ///Function for delete a user of user list
  Future<void> deleteUser(String id, int indexRow) async {
    bool wasUserDelete = await googleSheetService.deleteUser(id, indexRow);
    _controllerDeleteUser.add(wasUserDelete);
  }
}
