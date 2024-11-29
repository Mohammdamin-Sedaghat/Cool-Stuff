import {orders} from '../data/orders.js';
import {makeTimeBetter} from './utils/day.js';
import { formatCurrency } from './utils/money.js';
import { findMatch, loadProductsFetch } from '../data/products.js';
import { addToCart, updateCartQuantityHTML } from '../data/cart.js';

OrderPage();

async function OrderPage() {
    await loadProductsFetch();
    renderOrderPage();
}

function renderOrderPage() {
    let totalHTML = "";
    orders.forEach((orderItem)=>{
        totalHTML += `
            <div class="order-container">
            <div class="order-header">
                <div class="order-header-left-section">
                    <div class="order-date">
                    <div class="order-header-label">Order Placed:</div>
                    <div>${makeTimeBetter(orderItem.orderTime)}</div>
                    </div>
                    <div class="order-total">
                    <div class="order-header-label">Total:</div>
                    <div>${formatCurrency(orderItem.totalCostCents)}</div>
                    </div>
                </div>

                <div class="order-header-right-section">
                    <div class="order-header-label">Order ID:</div>
                    <div>${orderItem.id}</div>
                </div>
            </div>
            <div class="order-details-grid">
        `
        orderItem.products.forEach((orderedProduct) => {
            const matchingProduct = findMatch(orderedProduct.productId);
            //console.log(matchingProduct);
            //console.log(orderedProduct);
            totalHTML += `
                <div class="product-image-container">
                <img src=${matchingProduct.image}>
                </div>

                <div class="product-details">
                <div class="product-name">
                ${matchingProduct.name}
                </div>
                <div class="product-delivery-date">
                    Arriving on: ${orderedProduct.estimatedDeliveryTime}
                </div>
                <div class="product-quantity">
                    Quantity: ${orderedProduct.quantity}
                </div>
                <button class="buy-again-button button-primary buy-again-js" data-product-id="${matchingProduct.id}">
                    <img class="buy-again-icon" src="images/icons/buy-again.png">
                    <span class="buy-again-message">Buy it again</span>
                </button>
                </div>

                <div class="product-actions">
                <a href="tracking.html?productId:${matchingProduct.id}&orderId:${orderItem.id}">
                    <button class="track-package-button button-secondary">
                    Track package
                    </button>
                </a>
                </div>
            `
        });

        totalHTML += `
            </div>
        </div>
        `
    });

    document.querySelector('.orders-grid-js').innerHTML = totalHTML;

    updateCartQuantityHTML();

    document.querySelectorAll('.buy-again-js').forEach((button) => {
        button.addEventListener('click', () => {
            const productId = button.dataset.productId;
            addToCart(productId, 1);
            updateCartQuantityHTML();
        });
    });
}
