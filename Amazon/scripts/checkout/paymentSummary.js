import { cart } from "../../data/cart.js";
import { deliveryOptions } from "../../data/deliveryOptions.js";
import { products } from "../../data/products.js";
import { formatCurrency } from "../utils/money.js";

export function renderPaymentSymmary() {
    let itemCount = 0;
    let shippingPriceCents = 0;
    let itemPriceCents = 0;
    let taxPercent = 13;
    cart.forEach((cartItem) => {
        itemCount += cartItem.quantity;
        const {productId} = cartItem;
        products.forEach((product) => {
            if (product.id === productId) {
                itemPriceCents += cartItem.quantity * product.priceCents
            }
        });

        deliveryOptions.forEach((deliveryOptions) => {
            if (cartItem.delivaryOptionId === deliveryOptions.id) {
                shippingPriceCents += deliveryOptions.priceCents
            }
        });
    });
    let totalTax = (shippingPriceCents + itemPriceCents) * (taxPercent / 100);
    let totalHtml = `
          <div class="payment-summary-title">
            Order Summary
          </div>

          <div class="payment-summary-row">
            <div class="item-count-js-priceSummary">Items (${itemCount}):</div>
            <div class="payment-summary-money">$${formatCurrency(itemPriceCents)}</div>
          </div>

          <div class="payment-summary-row">
            <div>Shipping &amp; handling:</div>
            <div class="payment-summary-money">$${formatCurrency(shippingPriceCents)}</div>
          </div>

          <div class="payment-summary-row subtotal-row">
            <div>Total before tax:</div>
            <div class="payment-summary-money">$${formatCurrency(shippingPriceCents+ itemPriceCents)}</div>
          </div>

          <div class="payment-summary-row">
            <div>Estimated tax (%${taxPercent}):</div>
            <div class="payment-summary-money">$${formatCurrency(totalTax)}</div>
          </div>

          <div class="payment-summary-row total-row">
            <div>Order total:</div>
            <div class="payment-summary-money">$${formatCurrency(totalTax + shippingPriceCents + itemPriceCents)}</div>
          </div>

          <button class="place-order-button button-primary">
            Place your order
          </button>
        
    `;
    document.querySelector('.js-payment-summary').innerHTML = totalHtml;
}