import { renderOrderSummary } from "./checkout/orderSummary.js";
import { renderPaymentSymmary } from "./checkout/paymentSummary.js";
import { loadProducts } from "../data/products.js";

/*
new Promise((resolve) => {
    loadProducts(()=> {
        resolve();
    });
}).then(()=> {
    
})
*/

loadProducts(renderCheckOutPage);

function renderCheckOutPage() {
    renderPaymentSymmary();
    renderOrderSummary();

}
