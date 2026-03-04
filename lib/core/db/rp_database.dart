abstract interface class RPDatabase {
  Future<void> connect();
  Future<void> disconnect();
}
