// ignore: file_names
import 'package:hive/hive.dart';
import 'package:workout_app/model/user_modal.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    return User(
      name: reader.readString(),
      email: reader.readString(),
      number: reader.readString(),
      age: reader.readInt(),
      height: reader.readDouble(),
      weight: reader.readDouble(),
      sex: reader.readString(),
      completedExercises: reader.readList().cast<String>(),
      enableBackgroundMusic: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.number);
    writer.writeInt(obj.age);
    writer.writeDouble(obj.height);
    writer.writeDouble(obj.weight);
    writer.writeString(obj.sex);
    writer.writeList(obj.completedExercises);
    writer.writeBool(obj.enableBackgroundMusic);
  }
}
