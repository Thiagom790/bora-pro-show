import 'package:mobx/mobx.dart';
part 'profile.store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  @observable
  String userUid = "";

  @observable
  String role = "";

  @observable
  String name = "";

  @observable
  String id = "";

  @action
  void setProfile({
    required userUid,
    required role,
    required name,
    required id,
  }) {
    this.userUid = userUid;
    this.role = role;
    this.name = name;
    this.id = id;
  }
}
