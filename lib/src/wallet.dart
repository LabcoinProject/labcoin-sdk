import 'package:crypton/crypton.dart';

class Wallet {
  ECPrivateKey _privateKey;

  ECPublicKey get publicKey => _privateKey.publicKey;
  ECPrivateKey get privateKey => _privateKey;

  Wallet(String privateKey) {
    _privateKey = ECPrivateKey.fromString(privateKey);
  }

  Wallet.fromRandom() {
    var keypair = ECKeypair.fromRandom();
    _privateKey = keypair.privateKey;
  }
}
