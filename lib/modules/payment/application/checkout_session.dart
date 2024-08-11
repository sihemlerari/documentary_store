class CheckoutSession {
  final String checkoutUrl;
  final String successUrl;
  final String failureUrl;

  const CheckoutSession({
    required this.checkoutUrl,
    required this.successUrl,
    required this.failureUrl,
  });
}
