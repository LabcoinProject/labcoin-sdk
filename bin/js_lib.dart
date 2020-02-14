import 'dart:js' as js;

import 'package:crypton/crypton.dart';
import 'package:labcoin_sdk/labcoin_sdk.dart';

void main() {
  Wallet createWallet(String privateKey) => Wallet(privateKey);

  Wallet createRandomWallet() => Wallet.fromRandom();

  String getPublicAddress(Wallet wallet) => wallet.publicKey.toString();

  String getPrivateKey(Wallet wallet) => wallet.privateKey.toString();

  Transaction createTransaction(
          String fromAddress, String toAddress, int amount) =>
      Transaction(fromAddress, toAddress, amount);

  Transaction signTransaction(
      Transaction transaction, String privateKey) {
    transaction.signTransaction(ECPrivateKey.fromString(privateKey));
    return transaction;
  }

  // Wallet
  js.context['labcoin_createWallet'] = createWallet;
  js.context['labcoin_createRandomWallet'] = createRandomWallet;
  js.context['labcoin_getPublicAddress'] = getPublicAddress;
  js.context['labcoin_getPrivateKey'] = getPrivateKey;

  // Transaction
  js.context['labcoin_createTransaction'] = createTransaction;
  js.context['labcoin_signTransaction'] = signTransaction;
}
