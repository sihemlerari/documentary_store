import Stripe from "stripe";
import { defineSecret } from "firebase-functions/params";
import { HttpsError, onRequest } from "firebase-functions/v2/https";
import { getDocumentaryBy } from "../../documentaries/getDocumentaryBy";
import { createOrder } from "../../orders/createOrder";

const stripeSecretKey = defineSecret("STRIPE_SECRET_KEY");
const stripeWebhookSecret = defineSecret("STRIPE_WEBHOOK_SECRET");

export const onStripeSuccessfulPayment = onRequest(
  { secrets: [stripeSecretKey] },
  async (request, response) => {
    const event = verifyStripeWebhookSignature(request);

    if (event.type === "payment_intent.succeeded") {
      const paymentIntent = event.data.object as Stripe.PaymentIntent;
      await handleSuccessfulPayment(paymentIntent);
    }
    response.json({ received: true });
  }
);

function verifyStripeWebhookSignature(request: any): Stripe.Event {
  const sig = request.headers["stripe-signature"] as string;
  const stripe = new Stripe(stripeSecretKey.value(), {
    apiVersion: "2024-06-20",
  });

  try {
    return stripe.webhooks.constructEvent(
      request.rawBody,
      sig,
      stripeWebhookSecret.value()
    );
  } catch {
    throw new HttpsError("internal", "Invalid webhook signature");
  }
}

async function handleSuccessfulPayment(paymentIntent: Stripe.PaymentIntent) {
  const documentaryId = paymentIntent.metadata.documentaryId;
  const documentary = await getDocumentaryBy(documentaryId);
  if (!documentary) {
    throw new HttpsError("not-found", "Documentary not found.");
  }

  await createOrder({
    customerId: paymentIntent.metadata.customerId,
    documentary,
    amount: paymentIntent.amount,
    paymentId: paymentIntent.id,
  });
}
