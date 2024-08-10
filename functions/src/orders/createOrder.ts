import * as admin from "firebase-admin";
import { Documentary } from "../documentaries/documentary";

const RENT_DAYS = 2;

export async function createOrder({
  customerId,
  documentary,
  amount,
  paymentId,
}: {
  customerId: string;
  documentary: Documentary;
  amount: number;
  paymentId: string;
}): Promise<void> {
  const purchaseDate = new Date();

  let expirationDate: Date | null = null;
  if (documentary.purchaseOption === "rent") {
    expirationDate = new Date(purchaseDate);
    expirationDate.setDate(expirationDate.getDate() + RENT_DAYS);
  }

  const order = {
    customerId,
    documentary: {
      id: documentary.id,
      name: documentary.name,
    },
    price: amount,
    purchaseDate,
    expirationDate,
    paymentId,
  };

  await admin.firestore().collection("orders").add(order);
}
