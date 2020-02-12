bool containsKeys(Map<String, dynamic> map, List<String> keys) {
  for (var key in keys) {
    if (!map.containsKey(key)) {
      return false;
    }
  }
  return true;
}
