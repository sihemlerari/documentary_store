export interface Documentary {
  id: string;
  name: string;
  price: number;
  purchaseOption: PurchaseOption;
}

type PurchaseOption = "rent" | "buy";
