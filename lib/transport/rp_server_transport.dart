abstract interface class RPServerTransport<OfType> {
  Future<OfType> makeServer();
}
