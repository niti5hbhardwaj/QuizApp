import 'data.dart';

Future<void> updateData() async {
  await Future.delayed(Duration(seconds: 2), () {
    data.replaceRange(0, data.length, [1, 2, 3]);
  });
}
