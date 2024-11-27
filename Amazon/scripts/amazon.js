import {cart, addToCart} from '../data/cart.js';
import { products } from '../data/products.js';
import { formatCurrency } from './utils/money.js';

//displaying the products into the page
let prodcutContainerElem = document.querySelector('.products-grid');
let productsHTML = "";
products.forEach((product) => {
    productsHTML += `
        <div class="product-container">
          <div class="product-image-container">
            <img class="product-image"
              src="${product.image}">
          </div>

          <div class="product-name limit-text-to-2-lines">
            ${product.name}
          </div>

          <div class="product-rating-container">
            <img class="product-rating-stars"
              src="images/ratings/rating-${product.rating.stars * 10}.png">
            <div class="product-rating-count link-primary">
              ${product.rating.count}
            </div>
          </div>

          <div class="product-price">
            $${formatCurrency(product.priceCents)}
          </div>

          <div class="product-quantity-container">
            <select class="js-quantity-selector-${product.id}">
              <option selected value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="7">7</option>
              <option value="8">8</option>
              <option value="9">9</option>
              <option value="10">10</option>
            </select>
          </div>

          ${product.extraInfoHTML()}

          <div class="product-spacer"></div>

          <div class="added-to-cart added-to-cart-${product.id}">
            <img src="images/icons/checkmark.png">
            Added
          </div>


          <button class="add-to-cart-button button-primary js-add-to-cart" 
            data-product-id="${product.id}">
            Add to Cart
          </button>
        </div>
    `;
});

//displaying the quantity into the page
updateCartQuantity();

//Adding an Event Listener for each button. 
prodcutContainerElem.innerHTML = productsHTML;
document.querySelectorAll('.js-add-to-cart').forEach((button) => {
    button.addEventListener('click', () => {
        const { productId } = button.dataset;
        addToCart(productId);
        updateCartQuantity();
        updateAddedText(productId);
    });
});

//constructing a timeIntervalId so that the checkmarks don't dissapear if pressed multiple times. 
let timeOutIntervalId = {
  productId: 0,
  timeId: 0,
};
//Displaying the added Checkmark.
function updateAddedText(productId) {
  let addedToCartElement = document.querySelector(`.added-to-cart-${productId}`);
  //making sure that if the user keeps pressing it, it doesn't disapear midway. 
  if (timeOutIntervalId.productId === productId) {
    clearTimeout(timeOutIntervalId.timeId);
  }
  //actually showing it. 
  addedToCartElement.style.opacity = '1';
  //making sure it dissapears after 2 seconds 
  let timeId = setTimeout(() => {
    addedToCartElement.style.opacity = '0';
  }, 2000);

  //updating time interval id. 
  timeOutIntervalId.timeId = timeId;
  timeOutIntervalId.productId = productId;
};

//Function to update the quanity of the cart (top right corner)
function updateCartQuantity() {
    const quantityElement = document.querySelector('.cart-quantity-js');
    let total = 0;
    cart.forEach((cartItem) => {
        total += cartItem.quantity;
    });
    quantityElement.innerHTML = total;
}
