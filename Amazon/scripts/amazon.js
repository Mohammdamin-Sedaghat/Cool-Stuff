let prodcutContainerElem = document.querySelector('.products-grid');
let productsHTML = "";
products.forEach((item, index) => {
    productsHTML += `
        <div class="product-container">
          <div class="product-image-container">
            <img class="product-image"
              src="${item.image}">
          </div>

          <div class="product-name limit-text-to-2-lines">
            ${item.name}
          </div>

          <div class="product-rating-container">
            <img class="product-rating-stars"
              src="images/ratings/rating-${item.rating.stars * 10}.png">
            <div class="product-rating-count link-primary">
              ${item.rating.count}
            </div>
          </div>

          <div class="product-price">
            $${item.priceCents / 100}
          </div>

          <div class="product-quantity-container">
            <select class="js-quantity-selector-${item.id}">
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

          <div class="product-spacer"></div>

          <div class="added-to-cart">
            <img src="images/icons/checkmark.png">
            Added
          </div>

          <button class="add-to-cart-button button-primary js-add-to-cart" 
            data-product-id="${item.id}">
            Add to Cart
          </button>
        </div>
    `;
});

prodcutContainerElem.innerHTML = productsHTML;
document.querySelectorAll('.js-add-to-cart').forEach((button, index) => {
    button.addEventListener('click', () => {
        const productId = button.dataset.productId;
        const quantityElem = document.querySelector(`.js-quantity-selector-${productId}`);
        let isIn = false;
        cart.forEach((item) => {
            if (item.productId === productId) {
                item.quantity += Number(quantityElem.value);
                isIn = true;
                return;
            }
        });

        if (!isIn) {
            cart.push({
                productId,
                quantity: Number(quantityElem.value)
            });
        }
        updateQuantity();
        console.log(cart);
    });
});

function updateQuantity() {
    const quantityElement = document.querySelector('.cart-quantity-js');
    let total = 0;
    cart.forEach((product) => {
        total += product.quantity;
    });
    quantityElement.innerHTML = total;
}
