
import 'package:hive/hive.dart';

part 'UserHive.g.dart';

@HiveType(typeId: 0)
class UserHive extends HiveObject {
  UserHive({
    required this.username,
    required this.email,
    required this.password,
  });

  @HiveField(0)
  String? username;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? password;
}

// flutter pub run build_runner build --delete-conflicting-outputs
// El comando anterior se utiliza para generar el codigo HIVE para BDLocal