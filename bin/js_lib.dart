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
    transaction.sign(ECPrivateKey.fromString(privateKey));
    return transaction;
  }

  LabcoinUri getLabcoinUri(String nodeAddress, bool https, String path) {
    var scheme = Schemes.HTTP;
    if (https) {
      scheme = Schemes.HTTPS;
    }
    return LabcoinUri(nodeAddress, scheme: scheme, path: path);
  }

  String getLabcoinUrl(LabcoinUri nodeUri) {
    return nodeUri.toString();
  }

  LabcoinClient getClient(LabcoinUri nodeAddress) {
    return LabcoinClient(nodeAddress);
  }

  void sendTransaction(LabcoinClient labcoinClient, Transaction transaction) {
    labcoinClient.sendTransaction(transaction);
  }


  // Wallet
  js.context['labcoin_createWallet'] = createWallet;
  js.context['labcoin_createRandomWallet'] = createRandomWallet;
  js.context['labcoin_getPublicAddress'] = getPublicAddress;
  js.context['labcoin_getPrivateKey'] = getPrivateKey;

  // Transaction
  js.context['labcoin_createTransaction'] = createTransaction;
  js.context['labcoin_signTransaction'] = signTransaction;

  // Client
  js.context['labcoin_getLabcoinUri'] = getLabcoinUri;
  js.context['labcoin_getLabcoinUrl'] = getLabcoinUrl;
  js.context['labcoin_getClient'] = getClient;
  js.context['labcoin_getSendTransaction'] = sendTransaction;
}
