import '../classes/rutines.dart';
import '../classes/user.dart';

class RutinesDto {
  final int id;
  final String rutine;
  final int userId;
  final String date;
  final String completed;

  RutinesDto(
      {required this.id,
      required this.userId,
      required this.rutine,
      required this.date,
      required this.completed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'rutine': rutine,
      'date': date,
      'completed': completed,
    };
  }

  // ignore: non_constant_identifier_names
  static Future<String> printAllRutines(
      Future<List<Rutines>> allRutines, Future<List<User>> users) async {
    String routines = '';
    int? idUser = 0;

    List<User> userList = await users;

    for (User user in userList) {
      print('ID: ${user.id}, Name: ${user.name}');
      idUser = user.id;
    }

    List<Rutines> rutinesList = await allRutines;

    for (Rutines rut in rutinesList) {
      if (rut.userId == idUser) {
        routines =
            '$routines ${rut.id}, ${rut.rutine}, ${rut.date}, ${rut.completed} \n';
      }
    }

    print(routines);
    return routines;
  }
}
