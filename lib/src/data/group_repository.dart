import 'package:ayad/src/models/group.dart';

abstract class GroupRepository {
  Future<List<Group>> getMainGroup({required GroupType groupType ,bool? isHiden});
  Future<void> create(Group group);
  Future<void> update(Group group);
  Future<void> delete(String groupId);
  Future<List<Group>> getSubGruops(String parentGroupId);
  }