enum OAuthenticationProvider {
  google,
}

class OAuthenticationCredential {
  final OAuthenticationProvider provider;
  final String? accessToken;
  final String? idToken;

  const OAuthenticationCredential({
    required this.provider,
    this.accessToken,
    this.idToken,
  });
}
