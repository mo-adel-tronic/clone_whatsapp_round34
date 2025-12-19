class AgoraConfig {
  /// Your Agora project App ID from Agora Console.
  static const String appId = 'f10740e1cc22423faec7b271c77da3c9';

  /// For quick testing you can leave this empty ("") if your project
  /// has **no App Certificate** enabled.
  /// In production you must generate a token from a secure server.
  static const String devToken =
      '007eJxTYKiPZ3v16XxM1dvfcRqTJt7N3VrFvd1koX75ZP8tTLtnidgpMKQZGpibGKQaJicbGZkYGaclpiabJxmZGyabm6ckGidbOp52zWwIZGRYMbWclZEBAkF8HoaS1OKS+OSMxLy81BwGBgCRwiMt';

  /// If you want to test 1-to-1 calls between two devices,
  /// use the same channel id on both sides.
  static String buildChannelId(String callId) =>
      callId.isNotEmpty ? 'call_$callId' : 'sample_channel';
}
