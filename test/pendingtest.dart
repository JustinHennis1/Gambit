import 'package:gambit/services/getpending.dart'; // Update with the correct file path

void main() async {
  // Replace 'your_username' with the actual username you want to test
  final List<String>? pendingList = await getAllPending('Picky');

  if (pendingList != null) {
    print('Pending List: $pendingList');
  } else {
    print('Failed to fetch pending list.');
  }
}
