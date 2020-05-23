enum Schemes { HTTP, HTTPS }

class LabcoinUri {
  String _scheme = 'http';
  final String _nodeAddress;
  String _path;

  String get scheme => _scheme;
  String get nodeAddress => _nodeAddress;
  String get path => _path;

  /// Create a Labcoin Uri
  /// [nodeAddress] should be like host:port
  LabcoinUri(this._nodeAddress,
      {Schemes scheme = Schemes.HTTP, String path = ''}) {
    if (scheme == Schemes.HTTPS) {
      _scheme = 'https';
    }
    _path = path.split('/').join('/');
  }

  @override
  String toString() => '$scheme://$nodeAddress/$path';
}
