import { renderOrderSummary } from "./checkout/orderSummary.js";
import { renderPaymentSymmary } from "./checkout/paymentSummary.js";
import { loadProductsFetch } from "../data/products.js";

/*
new Promise((resolve) => {
    loadProducts(()=> {
        resolve();
    });
}).then(()=> {
    
})
*/

loadProductsFetch().then(() => {renderCheckOutPage()});

function renderCheckOutPage() {
    renderPaymentSymmary();
    renderOrderSummary();

}
