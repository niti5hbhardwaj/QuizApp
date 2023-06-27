import 'data.dart';
import 'testing_async.dart';

void main() {
  List<int> data2 = data;
  print(data2);
  bool dataLoaded = false;
  loadData().then((value) => {print(data)});
}

Future<void> loadData() async {
  await updateData();
}
