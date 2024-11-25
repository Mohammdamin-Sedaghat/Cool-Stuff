import {cart, removeFromCart, updateQuanitty, updateDeliveryOptionId} from '../../data/cart.js';
import {products} from '../../data/products.js';
import {deliveryOptions} from '../../data/deliveryOptions.js';
import { formatCurrency } from '../utils/money.js';
import dayjs from 'https://unpkg.com/dayjs@1.11.10/esm/index.js';

export function suck() {
    console.log('suck my dick');
}

//Function to display the cart. 
export function renderOrderSummary() {
    let cartSummaryHTML = "";
    cart.forEach((cartItem) => {
        let desiredProduct;
        products.forEach((product) => {
            if (product.id === cartItem.productId) {
                desiredProduct = product;
            }
        });

        const deliveryOptionId = cartItem.delivaryOptionId;
        let deliveryDate = getDate(deliveryOptionId);
        

        cartSummaryHTML += `
        <div class="cart-item-container js-cart-container-${desiredProduct.id}">
            <div class="delivery-date delivery-date-js-${desiredProduct.id}">
                Delivery date: ${deliveryDate}
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
                    <span class="update-quantity-link link-primary update-quantity-js update-product-id-${desiredProduct.id}" 
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
                    ${delivaryOptionsHTML(desiredProduct.id, cartItem.delivaryOptionId)}
                </div>
            </div>
        </div>
        `
    });
    document.querySelector('.order-summary-js').innerHTML = cartSummaryHTML;

updateCartQuantity();

    //function to get the date for a certain number of days in future. 
    function getDate(deliveryOptionId) {
        let deliveryDate;
        deliveryOptions.forEach((deliveryOptionItem)=> {
            if (deliveryOptionItem.id === deliveryOptionId) {
                deliveryDate = dayjs().add(deliveryOptionItem.deliveryDays, 'days').format('dddd, MMMM D');
            }
        });
        return deliveryDate
    };

    //generating the delivery options
    function delivaryOptionsHTML(productId, wantedId) {
        let totalHTML = "";
        deliveryOptions.forEach((delivaryOption) => {
            const today = dayjs();
            const delivaryDay = today.add(delivaryOption.deliveryDays, 'days').format('dddd, MMMM D');
            const priceDisplay = delivaryOption.priceCents === 0 ? 'FREE' : `$${formatCurrency(delivaryOption.priceCents)} -`
            const isCheck = (delivaryOption.id === wantedId);
            totalHTML += `
                <div class="delivery-option">
                    <input type="radio"
                    ${isCheck && 'Checked'}
                    class="delivery-option-input delivery-option-radio-${productId}-${delivaryOption.id}"
                    name="delivery-option-${productId}"
                    value="${delivaryOption.id}">
                    <div>
                    <div class="delivery-option-date">
                        ${delivaryDay}
                    </div>
                    <div class="delivery-option-price">
                        ${priceDisplay} Shipping
                    </div>
                    </div>
                </div>
            `;
        })
        
        return totalHTML;
    }

    //adding event listeners for delivery options. 
    document.querySelectorAll('.delivery-option-input').forEach((deliveryLink)=> {
        deliveryLink.addEventListener('click', () => {
            const productId = deliveryLink.name.slice(16);
            const value = deliveryLink.value;
            updateDeliveryOptionId(productId, value);
            renderOrderSummary();
        });
    });

    //Adding event listeners for the delete buttons. 
    document.querySelectorAll('.delete-js').forEach((link) => {
        link.addEventListener('click', () => {
            const productId = link.dataset.productId;
            removeFromCart(productId);
            updateCartQuantity();
            document.querySelector(`.js-cart-container-${productId}`).remove();
        });
    });

    //Adding event listeners fro the update button. 
    document.querySelectorAll('.update-quantity-js').forEach((link) => {
        link.addEventListener('click', () => {
            const productId = link.dataset.productId;
            const quanittyElem = document.querySelector(`.quantity-label-js-${productId}`);
            if (link.innerHTML.trim() === 'Update') {
                link.innerHTML = 'Save';
                quanittyElem.innerHTML = `
                <input type="number" class="quantity-input quantity-input-${productId}" value="${quanittyElem.innerHTML}" min='1'>
                `;
                document.querySelector(`.quantity-input-${productId}`).addEventListener('keydown', (myEvent) => {
                    if (myEvent.key === 'Enter') {
                        document.querySelector(`.update-product-id-${productId}`).click();
                    }
                })
            } else {
                link.innerHTML = 'Update';
                const inputElem = document.querySelector(`.quantity-input-${productId}`);
                quanittyElem.innerHTML = `${inputElem.value}`;
                updateQuanitty(productId, Number(inputElem.value));
                updateCartQuantity();
            }
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
}