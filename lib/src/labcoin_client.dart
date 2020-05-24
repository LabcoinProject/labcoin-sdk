import 'dart:convert';

import 'package:http/http.dart';
import 'package:labcoin_sdk/labcoin_sdk.dart';
import 'package:labcoin_sdk/src/utils/utils.dart';

class LabcoinClient {
  LabcoinUri nodeAddress;

  LabcoinClient(this.nodeAddress);

  Future<List<Block>> _sendBlockchainRequest(String pathSegment) async {
    var response =
        await get('${nodeAddress.toString()}blockchain/$pathSegment');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var blocks = <Block>[];
      body.forEach((var trx) {
        blocks.add(Block.fromMap(trx));
      });
      return blocks;
    }
    return null;
  }

  void sendTransaction(BlockDataType transaction) =>
      post('${nodeAddress.toString()}transaction',
          body: jsonEncode(transaction.toMap()));

  void sendBlock(Block block) =>
      post('${nodeAddress.toString()}block', body: jsonEncode(block.toMap()));

  void registerNode(String uri, String address) =>
      post('${nodeAddress.toString()}node',
          body: jsonEncode({'uri': uri, 'address': address}));

  Future<BlockchainInfo> getBlockchainInfo() async {
    var response = await get('${nodeAddress.toString()}blockchain');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      var firstBlock = Block.fromMap(body['firstBlock']);
      var lastBlock = Block.fromMap(body['lastBlock']);
      var proofOfWorkChar = body['proofOfWorkChar'];
      var difficulty = body['difficulty'];
      return BlockchainInfo(difficulty, proofOfWorkChar, firstBlock, lastBlock);
    }
    return null;
  }

  Future<List<Block>> getFullBlockchain() async => _sendBlockchainRequest('full');

  Future<List<Block>> getNewestBlocks(int length) async {
    if (!length.isNegative) {
      length *= -1;
    }
    var lengthString = length.toString();
    return _sendBlockchainRequest(lengthString);
  }

  Future<List<Block>> getOldestBlocks(int length) async {
    if (length.isNegative) {
      length *= -1;
    }
    var lengthString = length.toString();
    return _sendBlockchainRequest(lengthString);
  }

  Future<List<BlockDataType>> getMemPoolTransactions() async {
    var response = await get('${nodeAddress.toString()}mempool/transactions');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var memPoolTransactions = <BlockDataType>[];
      body.forEach((var trx) {
        var resolvedTrx = getBlockDataTypeFromMap(trx);
        if (response != null) {
          memPoolTransactions.add(resolvedTrx);
        }
      });
      return memPoolTransactions;
    }
    return null;
  }

  Future<LabcoinAddress> getAddress(String walletAddress) async {
    var response = await get(
        '${nodeAddress.toString()}wallet/${Uri.encodeQueryComponent(walletAddress)}');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var funds = body['funds'] as int;
      var transactions = <BlockDataType>[];
      body['transactions'].forEach((var trx) {
        transactions.add(getBlockDataTypeFromMap(trx));
      });
      var memPoolTransactions = <BlockDataType>[];
      body['memPoolTransactions'].forEach((var trx) {
        memPoolTransactions.add(getBlockDataTypeFromMap(trx));
      });
      return LabcoinAddress(walletAddress, funds, transactions, memPoolTransactions);
    }
    return null;
  }
}
