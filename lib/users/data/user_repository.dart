
import "../domain/user.dart";
abstract class UserRepository{
 Future<void> create(AppUser appUser);
 Future<AppUser> update(AppUser user);
 Future<bool> delete(String userId);
 Future<List<AppUser>?> getAll();
 Future<AppUser?> loginIn(String username,String password);
 Future<bool> checkUsername(String username);
  Future<bool> checkUsernameWithId(String username,String id);

}