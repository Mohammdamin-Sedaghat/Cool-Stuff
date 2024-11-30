import { renderOrderSummary } from "./checkout/orderSummary.js";
import { renderPaymentSymmary } from "./checkout/paymentSummary.js";
import { loadProductsFetch } from "../data/products.js";

loadProductsFetch().then(()=> {
    renderPaymentSymmary();
    renderOrderSummary();
});