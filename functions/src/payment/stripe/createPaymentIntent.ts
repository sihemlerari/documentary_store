import * as admin from "firebase-admin";
import Stripe from "stripe";
import { defineSecret } from "firebase-functions/params";
import { HttpsError, onCall } from "firebase-functions/v2/https";

const stripeSecretKey = defineSecret("STRIPE_SECRET_KEY");

admin.initializeApp();

interface CreatePaymentIntentParams {
  amount: number;
  currency: string;
}

export const stripeCreatePaymentIntent = onCall<CreatePaymentIntentParams>(
  { secrets: [stripeSecretKey] },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "You need to be authenticated to perform this action."
      );
    }

    const stripe = new Stripe(stripeSecretKey.value());

    const { amount, currency } = request.data;
    const paymentIntent = await stripe.paymentIntents.create({
      amount: convertToSmallestUnit(amount, currency),
      currency,
      receipt_email: request.auth.token.email,
      payment_method_types: ["card"],
    });

    return { clientSecret: paymentIntent.client_secret };
  }
);

function convertToSmallestUnit(amount: number, currency: string): number {
  if (currency !== "usd") {
    throw new HttpsError("invalid-argument", "Only USD currency is supported.");
  }
  return amount * 100;
}
