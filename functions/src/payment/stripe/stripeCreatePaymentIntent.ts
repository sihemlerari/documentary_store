import Stripe from "stripe";
import { defineSecret } from "firebase-functions/params";
import {
  CallableRequest,
  HttpsError,
  onCall,
} from "firebase-functions/v2/https";
import { getDocumentaryBy } from "../../documentaries/getDocumentaryBy";
import { AuthData } from "firebase-functions/lib/common/providers/https";

const stripeSecretKey = defineSecret("STRIPE_SECRET_KEY");

interface CreatePaymentIntentParams {
  documentaryId: string;
  currency: string;
}

export const stripeCreatePaymentIntent = onCall<CreatePaymentIntentParams>(
  { secrets: [stripeSecretKey] },
  async (request) => {
    validateRequest(request);

    const { documentaryId, currency } = request.data;
    const amount = await processAmount(documentaryId, currency);

    const paymentIntent = await createPaymentIntent(
      amount,
      currency,
      documentaryId,
      request.auth!
    );

    return { clientSecret: paymentIntent.client_secret };
  }
);

function validateRequest(
  request: CallableRequest<CreatePaymentIntentParams>
): void {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "You need to be authenticated to perform this action."
    );
  }

  if (!request.data.documentaryId || !request.data.currency) {
    throw new HttpsError(
      "invalid-argument",
      "documentaryId and currency must be provided."
    );
  }
}

async function processAmount(
  documentaryId: string,
  currency: string
): Promise<number> {
  const documentary = await getDocumentaryBy(documentaryId);
  if (!documentary) {
    throw new HttpsError("not-found", "Documentary not found.");
  }

  return convertToSmallestUnit(documentary.price, currency);
}

function convertToSmallestUnit(amount: number, currency: string): number {
  if (currency !== "usd") {
    throw new HttpsError("invalid-argument", "Only USD currency is supported.");
  }
  return amount * 100;
}

async function createPaymentIntent(
  amount: number,
  currency: string,
  documentaryId: string,
  auth: AuthData
) {
  const stripe = new Stripe(stripeSecretKey.value(), {
    apiVersion: "2024-06-20",
  });
  const paymentIntent = await stripe.paymentIntents.create({
    amount,
    currency,
    payment_method_types: ["card"],
    receipt_email: auth.token.email,
    metadata: {
      customerId: auth.uid,
      documentaryId,
    },
  });
  return paymentIntent;
}
