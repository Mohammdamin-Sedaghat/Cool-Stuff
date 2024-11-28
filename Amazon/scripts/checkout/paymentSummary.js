import { cart } from "../../data/cart.js";
import { deliveryOptions } from "../../data/deliveryOptions.js";
import { products } from "../../data/products.js";
import { formatCurrency } from "../utils/money.js";
import { addOrder } from '../../data/orders.js';

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

          <div class='paypal-input-container'>
          Use PayPal <input type='checkbox' class='paypal-input paypal-input-js'>
          </div>
          <div class='place-order-container'>
            <button class="place-order-button button-primary js-place-order">
              Place your order
            </button>
          </div>
        
    `;
    document.querySelector('.js-payment-summary').innerHTML = totalHtml;

    addEventForPlaceOrder();

    document.querySelector('.paypal-input-js').addEventListener('change', (event)=>{
      if (event.target.checked) {
        document.querySelector('.place-order-container').innerHTML = `
          <button class="place-order-button button-primary paypal-outer-button">
            <img src="./images/icons/paypal.svg" class="paypal-button"> 
          </button>
          <button class="place-order-button button-primary debit-credit-button">
            Debit or Credit Card
          </button>
        `;
      } else {
        document.querySelector('.place-order-container').innerHTML = `
          <button class="place-order-button button-primary js-place-order">
            Place your order
          </button>
        `;
        addEventForPlaceOrder();
      }
    })
}

function addEventForPlaceOrder() {
  document.querySelector('.js-place-order').addEventListener('click', async ()=>{
    try {
      const response = await fetch('https://supersimplebackend.dev/orders', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          cart: cart
        }),
      });

      const order  = await response.json();
      addOrder(order);
      window.location.href= "orders.html"
    } catch (error) {
      console.log(`encountered ${error}`);
    }
  });
}