import 'package:save_pass/models/resources/cryptograph.dart';


void main() async {
  Cryptograph c = Cryptograph('password');
  List<int> key = await c.generateKeyFromPass();

}
