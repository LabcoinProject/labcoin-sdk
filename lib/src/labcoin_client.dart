import 'dart:convert';

import 'package:http/http.dart';
import 'package:labcoin_sdk/labcoin_sdk.dart';

class LabcoinClient {
  LabcoinUri nodeAddress;

  LabcoinClient(this.nodeAddress) {
    print(nodeAddress.toString());
  }

  void sendTransaction(Transaction transaction) =>
      post('${nodeAddress.toString()}transaction', body: transaction.toMap());

  Future<int> getWalletBalance(String walletAddress) async {
    Response response =
        await get('${nodeAddress.toString()}wallet?walletId=$walletAddress');
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['funds'] as int;
    }
    return null;
  }
}
