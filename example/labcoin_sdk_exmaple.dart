import 'package:labcoin_sdk/labcoin_sdk.dart';

Future<void> main() async {
  // Establish a Connection to a Labcoin Node
  var labcoinClient = LabcoinClient(LabcoinUri('localhost:3001'));

  // Request the Wallet Balance of a specific Wallet address
  var stake = await labcoinClient
      .getAddress('A8sCvSG5hZknd3NklLlaF7pRpGxVUQdo5Ceh6KyXruBs');

  // Get the last/newest Block of the Blockchain
  var lastBlock = await labcoinClient.getNewestBlocks(1);

  // Get the first/oldest Block of the Blockchain
  var firstBlock = await labcoinClient.getOldestBlocks(1);

  // Get the full Blockchain
  var fullBlockchain = await labcoinClient.getFullBlockchain();

  print('Stake: ${stake.funds.toString()}');
  print('---[START] Last Block ---');
  print(lastBlock);
  print('---[END] Last Block ---\n---[START] First Block ---');
  print(firstBlock);
  print('---[END] First Block ---\n---[START] Full Blockchain ---');
  print(fullBlockchain);
  print('---[END] Full Blockchain ---');
}
