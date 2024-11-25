import {cart, removeFromCart, updateQuanitty} from '../data/cart.js';
import {products} from '../data/products.js';
import { formatCurrency } from './utils/money.js';
displayCart();
updateCartQuantity();

//Function to display the cart. 
function displayCart() {
    let cartSummaryHTML = "";
    cart.forEach((cartItem) => {
        let desiredProduct;
        products.forEach((product) => {
            if (product.id === cartItem.productId) {
                desiredProduct = product;
            }
        });

        cartSummaryHTML += `
        <div class="cart-item-container js-cart-container-${desiredProduct.id}">
            <div class="delivery-date">
                Delivery date: Tuesday, June 21
            </div>

            <div class="cart-item-details-grid">
                <img class="product-image"
                src="${desiredProduct.image}">

                <div class="cart-item-details">
                <div class="product-name">
                    ${desiredProduct.name}
                </div>
                <div class="product-price">
                    $${formatCurrency(desiredProduct.priceCents)}
                </div>
                <div class="product-quantity">
                    <span>
                    Quantity: <span class="quantity-label quantity-label-js-${desiredProduct.id}">${cartItem.quantity}</span>
                    </span>
                    <span class="update-quantity-link link-primary update-quantity-js" 
                        data-product-id='${desiredProduct.id}'>
                    Update
                    </span>
                    <span class="delete-quantity-link link-primary delete-js" data-product-id="${desiredProduct.id}">
                    Delete
                    </span>
                </div>
                </div>

                <div class="delivery-options">
                <div class="delivery-options-title">
                    Choose a delivery option:
                </div>
                <div class="delivery-option">
                    <input type="radio" checked
                    class="delivery-option-input"
                    name="delivery-option-${desiredProduct.id}">
                    <div>
                    <div class="delivery-option-date">
                        Tuesday, June 21
                    </div>
                    <div class="delivery-option-price">
                        FREE Shipping
                    </div>
                    </div>
                </div>
                <div class="delivery-option">
                    <input type="radio"
                    class="delivery-option-input"
                    name="delivery-option-${desiredProduct.id}">
                    <div>
                    <div class="delivery-option-date">
                        Wednesday, June 15
                    </div>
                    <div class="delivery-option-price">
                        $4.99 - Shipping
                    </div>
                    </div>
                </div>
                <div class="delivery-option">
                    <input type="radio"
                    class="delivery-option-input"
                    name="delivery-option-${desiredProduct.id}">
                    <div>
                    <div class="delivery-option-date">
                        Monday, June 13
                    </div>
                    <div class="delivery-option-price">
                        $9.99 - Shipping
                    </div>
                    </div>
                </div>
                </div>
            </div>
        </div>
        `
    });
    document.querySelector('.order-summary-js').innerHTML = cartSummaryHTML;
}

//Adding event listeners for the delete buttons. 
document.querySelectorAll('.delete-js').forEach((link) => {
    link.addEventListener('click', () => {
        const productId = link.dataset.productId;
        removeFromCart(productId);
        updateCartQuantity();
        document.querySelector(`.js-cart-container-${productId}`).remove();
    });
});

document.querySelectorAll('.update-quantity-js').forEach((link) => {
    link.addEventListener('click', () => {
        const productId = link.dataset.productId;
        console.log(productId);
        const quanittyElem = document.querySelector(`.quantity-label-js-${productId}`);
        if (link.innerHTML.trim() === 'Update') {
            link.innerHTML = 'Save';
            quanittyElem.innerHTML = `
            <input type="number" class="quantity-input quantity-input-${productId}" value="${quanittyElem.innerHTML}" min='1'>
            `;
        } else {
            link.innerHTML = 'Update';
            const inputAmnt = document.querySelector(`.quantity-input-${productId}`).value;
            quanittyElem.innerHTML = `${inputAmnt}`;
            updateQuanitty(productId, inputAmnt);
        }
        // link.innerHTML = link.innerHTML === 'Save' ? 'Update': 'Save';
    });
});

//function to update cart quantity
function updateCartQuantity() {
    let total = 0;
    cart.forEach((cartItem) => {
        total += cartItem.quantity;
    });
    document.querySelector(".item-count-js").innerHTML = `${total} items`;
}