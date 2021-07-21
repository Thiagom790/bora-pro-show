// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  final _$userUidAtom = Atom(name: '_ProfileStore.userUid');

  @override
  String get userUid {
    _$userUidAtom.reportRead();
    return super.userUid;
  }

  @override
  set userUid(String value) {
    _$userUidAtom.reportWrite(value, super.userUid, () {
      super.userUid = value;
    });
  }

  final _$roleAtom = Atom(name: '_ProfileStore.role');

  @override
  String get role {
    _$roleAtom.reportRead();
    return super.role;
  }

  @override
  set role(String value) {
    _$roleAtom.reportWrite(value, super.role, () {
      super.role = value;
    });
  }

  final _$nameAtom = Atom(name: '_ProfileStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$idAtom = Atom(name: '_ProfileStore.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore');

  @override
  void setProfile(
      {required dynamic userUid,
      required dynamic role,
      required dynamic name,
      required dynamic id}) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setProfile');
    try {
      return super.setProfile(userUid: userUid, role: role, name: name, id: id);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userUid: ${userUid},
role: ${role},
name: ${name},
id: ${id}
    ''';
  }
}
