import { defineSecret } from "firebase-functions/params";
import { HttpsError, onRequest } from "firebase-functions/v2/https";
import { getDocumentaryBy } from "../../documentaries/getDocumentaryBy";
import { createOrder } from "../../orders/createOrder";
import * as crypto from "crypto";
import { getUsdToDzdRate } from "./getUsdToDzdRate";

const chargilySecretKey = defineSecret("CHARGILY_SECRET_KEY");

interface ChargilyEvent {
  type: "checkout.paid" | "checkout.failed";
  data: {
    id: string;
    amount: number;
    metadata: any;
  };
}

export const onChargilySuccessfulPayment = onRequest(
  { secrets: [chargilySecretKey] },
  async (request, response) => {
    const event = verifyChargilyWebhookSignature(request);

    if (event.type === "checkout.paid") {
      await handleSuccessfulPayment(event);
    }
    response.json({ received: true });
  }
);

function verifyChargilyWebhookSignature(request: any): ChargilyEvent {
  const signature = request.get("signature");
  if (!signature) {
    throw new HttpsError("internal", "Missing signature");
  }

  const payload = JSON.stringify(request.body);
  const computedSignature = crypto
    .createHmac("sha256", chargilySecretKey.value())
    .update(payload)
    .digest("hex");

  if (computedSignature !== signature) {
    throw new HttpsError("internal", "Invalid webhook signature");
  }

  return request.body as ChargilyEvent;
}

async function handleSuccessfulPayment(event: ChargilyEvent) {
  const eventData = event.data;
  const documentaryId = eventData.metadata.documentaryId;
  const documentary = await getDocumentaryBy(documentaryId);
  if (!documentary) {
    throw new HttpsError("not-found", "Documentary not found.");
  }

  await createOrder({
    customerId: eventData.metadata.customerId,
    documentary,
    amount: convertDzdToUsd(eventData.amount),
    paymentId: eventData.id,
  });
}

function convertDzdToUsd(dzdAmount: number): number {
  return Math.round(dzdAmount / getUsdToDzdRate());
}
