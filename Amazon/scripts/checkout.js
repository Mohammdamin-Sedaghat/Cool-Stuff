import { renderOrderSummary } from "./checkout/orderSummary.js";
import { renderPaymentSymmary } from "./checkout/paymentSummary.js";
import { loadProductsFetch } from "../data/products.js";

async function renderCheckOutPage() {
    await loadProductsFetch()
    renderPaymentSymmary();
    renderOrderSummary();

}

renderCheckOutPage()