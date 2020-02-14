class LabcoinWallet {
    constructor(privateKey = null) {
        if (privateKey !== null) {
            this.wallet = labcoin_createWallet(privateKey);
        } else {
            this.wallet = labcoin_createRandomWallet();
        }
    }

    getPrivateKey() {return labcoin_getPrivateKey(this.wallet);}
    getPublicKey() {return labcoin_getPublicAddress(this.wallet);}
}

class LabcoinTransaction {
    constructor(fromAddress, toAddress, amount) {
        this.transaction = labcoin_createTransaction(
            fromAddress, toAddress, amount);
    }

    sign(privateKey) {
        this.transaction = labcoin_signTransaction(
            this.transaction, privateKey);
    }
}