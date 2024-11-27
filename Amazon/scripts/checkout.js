import { renderOrderSummary } from "./checkout/orderSummary.js";
import { renderPaymentSymmary } from "./checkout/paymentSummary.js";
import { loadProducts } from "../data/products.js";

loadProducts(renderCheckOutPage);

function renderCheckOutPage() {

    renderPaymentSymmary();
    renderOrderSummary();

}