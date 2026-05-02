enum SocketServerType {
  local,
  web;

  factory SocketServerType.fromString() {
    return switch (const String.fromEnvironment('SOCKET_SERVER_TYPE')) {
      'local' => local,
      'web' => web,
      _ => local,
    };
  }
}
