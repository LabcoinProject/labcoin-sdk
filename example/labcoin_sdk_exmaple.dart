import 'package:labcoin_sdk/labcoin_sdk.dart';

Future<void> main() async {
  LabcoinClient labcoinClient =
      LabcoinClient(LabcoinUri('localhost:3000'));
  int stake = await labcoinClient
      .getWalletBalance('00000000000000000000000000000000000000000000');
  print(stake);
}
