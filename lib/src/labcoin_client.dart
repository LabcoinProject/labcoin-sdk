import 'dart:convert';

import 'package:http/http.dart';
import 'package:labcoin_sdk/labcoin_sdk.dart';

class LabcoinClient {
  LabcoinUri nodeAddress;

  LabcoinClient(this.nodeAddress);

  Future<List> _sendBlockchainRequest(String pathSegment) async {
    var response =
        await get('${nodeAddress.toString()}blockchain/$pathSegment');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  void sendTransaction(Transaction transaction) =>
      post('${nodeAddress.toString()}transaction', body: jsonEncode(transaction.toMap()));

  Future<List> getFullBlockchain() async => _sendBlockchainRequest('full');

  Future<List> getNewestBlocks(int length) async {
    if (!length.isNegative) {
      length *= -1;
    }
    var lengthString = length.toString();
    return _sendBlockchainRequest(lengthString);
  }

  Future<List> getOldestBlocks(int length) async {
    if (length.isNegative) {
      length *= -1;
    }
    var lengthString = length.toString();
    return _sendBlockchainRequest(lengthString);
  }

  Future<int> getWalletBalance(String walletAddress) async {
    var response =
        await get('${nodeAddress.toString()}wallet?walletId=$walletAddress');
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['funds'] as int;
    }
    return null;
  }
}
