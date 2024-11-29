import { locateOrder } from "../data/orders.js";
import { findMatch, loadProductsFetch } from "../data/products.js";
import dayjs from 'https://unpkg.com/dayjs@1.11.10/esm/index.js';
import { updateCartQuantityHTML } from "../data/cart.js";

overAllRender();

async function overAllRender() {
    await loadProductsFetch();

    renderTrackingPage();
}

function renderTrackingPage() {
    const url = new URL(window.location.href);
    const matchingProduct = findMatch(url.searchParams.get('productId'));
    const matchingOrder = locateOrder(url.searchParams.get('orderId'));

    let productDetailInOrder;
    matchingOrder.products.forEach((product)=>{
        if (product.productId === matchingProduct.id) {
            productDetailInOrder = product;
        }
    });
    
    
    document.querySelector('.product-details').innerHTML = `
        <div class="delivery-date">
        Arriving on ${dayjs(productDetailInOrder.estimatedDeliveryTime).format('dddd, MMMM D')}
        </div>

        <div class="product-info">
        ${matchingProduct.name}
        </div>

        <div class="product-info">
        Quantity: ${productDetailInOrder.quantity}
        </div>

        <img class="product-image" src=${matchingProduct.image}>
    `;

    updateCartQuantityHTML();

    const totalTime = dayjs(productDetailInOrder.estimatedDeliveryTime) - dayjs(matchingOrder.orderTime);
    const timePassed = dayjs() - dayjs(matchingOrder.orderTime);
    const progressPercentage = 100* (timePassed / totalTime);
    document.querySelector('.progress-bar-js').style.width = `${Math.max(progressPercentage, 5)}%`;

    if (progressPercentage <= 40) {
        document.querySelector('.preparing-label-js').classList.add('current-status');
    } else if (progressPercentage <= 90) {
        document.querySelector('.shipped-label-js').classList.add('current-status');
    } else {
        document.querySelector('.delivered-label-js')
    }
}
