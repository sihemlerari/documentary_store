import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../modules/payment/application/checkout_session.dart';

class CheckoutWebview extends StatefulWidget {
  final CheckoutSession checkoutSession;
  final void Function() onSuccessfullPayment;
  final void Function() onFailedPayment;

  const CheckoutWebview(
    this.checkoutSession, {
    super.key,
    required this.onSuccessfullPayment,
    required this.onFailedPayment,
  });

  @override
  State<CheckoutWebview> createState() => _CheckoutWebviewState();
}

class _CheckoutWebviewState extends State<CheckoutWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final checkoutSession = widget.checkoutSession;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest navigationRequest) => _onNavigationRequest(
            navigationRequest,
            checkoutSession,
          ),
        ),
      )
      ..loadRequest(Uri.parse(checkoutSession.checkoutUrl));
  }

  NavigationDecision _onNavigationRequest(
    NavigationRequest navigationRequest,
    CheckoutSession checkoutSession,
  ) {
    final redirectUrl = navigationRequest.url;

    if (redirectUrl.startsWith(checkoutSession.successUrl)) {
      widget.onSuccessfullPayment();

      Navigator.of(context).pop();
      return NavigationDecision.prevent;
    }
    if (redirectUrl.startsWith(checkoutSession.failureUrl)) {
      widget.onFailedPayment();

      Navigator.of(context).pop();
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
