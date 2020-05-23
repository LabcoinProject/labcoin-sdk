import 'package:labcoin_sdk/labcoin_sdk.dart';

class LabcoinAddress{
  final String address;
  final int funds;
  final List<Transaction> transactions;
  final List<Transaction> memPoolTransactions;

  LabcoinAddress(this.address, this.funds, this.transactions, this.memPoolTransactions);
}