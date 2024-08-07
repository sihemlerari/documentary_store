import * as admin from "firebase-admin";
import { Documentary } from "./documentary";

export async function getDocumentaryBy(
  id: string
): Promise<Documentary | null> {
  const docSnapshot = await admin
    .firestore()
    .collection("documentaries")
    .doc(id)
    .get();

  const data = docSnapshot.data();
  if (!data) return null;

  if (data.purchaseOption.rent !== undefined) {
    return {
      id: docSnapshot.id,
      name: data.name,
      price: data.purchaseOption.rent.price,
      purchaseOption: "rent",
    } as Documentary;
  }

  return {
    id: docSnapshot.id,
    name: data.name,
    price: data.purchaseOption.buy.price,
    purchaseOption: "buy",
  } as Documentary;
}
