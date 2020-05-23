import 'package:labcoin_sdk/labcoin_sdk.dart';

class BlockchainInfo {
  final int difficulty;
  final Block firstBlock;
  final Block lastBlock;
  final String proofOfWorkChar;

  String get workRequirement {
    var requirement = StringBuffer();
    for (var i = 0; i < difficulty; i++) {
      requirement.write(proofOfWorkChar);
    }
    return requirement.toString();
  }

  BlockchainInfo(this.difficulty, this.proofOfWorkChar, this.firstBlock, this.lastBlock);

}