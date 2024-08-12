import { defineSecret } from "firebase-functions/params";
import {
  CallableRequest,
  HttpsError,
  onCall,
} from "firebase-functions/v2/https";
import { getDocumentaryBy } from "../../documentaries/getDocumentaryBy";
import { getUsdToDzdRate } from "./getUsdToDzdRate";

interface CreateCheckoutSessionParams {
  documentaryId: string;
}

interface CheckoutSession {
  checkoutUrl: string;
  successUrl: string;
  failureUrl: string;
}

const chargilySecretKey = defineSecret("CHARGILY_SECRET_KEY");

export const chargilyCreateCheckoutSession =
  onCall<CreateCheckoutSessionParams>(
    { secrets: [chargilySecretKey] },
    async (request) => {
      validateRequest(request);

      const { documentaryId } = request.data;
      const amount = await processAmount(documentaryId);

      return await createCheckoutSession(
        amount,
        request.auth!.uid,
        documentaryId
      );
    }
  );

function validateRequest(
  request: CallableRequest<CreateCheckoutSessionParams>
): void {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "You need to be authenticated to perform this action."
    );
  }

  if (!request.data.documentaryId) {
    throw new HttpsError("invalid-argument", "documentaryId must be provided.");
  }
}

async function processAmount(documentaryId: string): Promise<number> {
  const documentary = await getDocumentaryBy(documentaryId);
  if (!documentary) {
    throw new HttpsError("not-found", "Documentary not found.");
  }

  return convertUsdToDzd(documentary.price);
}

function convertUsdToDzd(usdAmount: number): number {
  return Math.round(usdAmount * getUsdToDzdRate());
}

async function createCheckoutSession(
  amount: number,
  customerId: string,
  documentaryId: string
): Promise<CheckoutSession> {
  const options = {
    method: "POST",
    headers: {
      Authorization: `Bearer ${chargilySecretKey.value()}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      amount: amount,
      currency: "dzd",
      success_url: "https://documentary-store.com/payments/success",
      failure_url: "https://documentary-store.com/payments/failure",
      payment_method: "edahabia",
      locale: "en",
      metadata: {
        documentaryId: documentaryId,
        customerId: customerId,
      },
    }),
  };

  const response = await fetch(
    "https://pay.chargily.net/test/api/v2/checkouts",
    options
  );
  const result = await response.json();

  if (response.ok) {
    return {
      checkoutUrl: result.checkout_url,
      successUrl: result.success_url,
      failureUrl: result.failure_url,
    };
  }
  throw new HttpsError("unknown", "Failed to create checkout session", result);
}
