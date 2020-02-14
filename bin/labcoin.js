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

class LabcoinUri {
    constructor(nodeAddress, https = false, path = '') {
        this.validUri = labcoin_getLabcoinUri(nodeAddress, https, path);
    }
    getUrl() {return labcoin_getLabcoinUrl(this.validUri);}
}

class LabcoinClient {
    constructor(nodeAddress) {
        this.connectedNode = labcoin_getClient(nodeAddress);
    }
    sendTransaction(labcoinTransaction) {
        labcoin_getSendTransaction(this.connectedNode, labcoinTransaction.transaction);
    }
}