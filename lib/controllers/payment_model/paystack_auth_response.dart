class PayStackAuthResponse {
  final String authorization_url;
  final String access_code;
  final String reference;

  PayStackAuthResponse({
    required this.authorization_url,
    required this.access_code,
    required this.reference,
  });

  factory PayStackAuthResponse.fromJson(Map<String, dynamic> json) {
    return PayStackAuthResponse(
      authorization_url: json['authorization_url'],
      access_code: json['access_code'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorization_url': authorization_url,
      'access_code': access_code,
      'reference': reference,
    };
  }
}