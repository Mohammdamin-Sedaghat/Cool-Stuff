export let cart = JSON.parse(localStorage.getItem('cart')) || [];

export function saveToStorage() {
    localStorage.setItem('cart', JSON.stringify(cart));
}

export function addToCart(productId) {
    //getting the quantity.
    const quantityElem = document.querySelector(`.js-quantity-selector-${productId}`);
    let isIn = false;
    cart.forEach((cartItem) => {
        if (cartItem.productId === productId) {
            cartItem.quantity += Number(quantityElem.value);
            isIn = true;
        }
    });
  
    //making sure we are only updating the quanity for elements already in the cart. 
    if (!isIn) {
        cart.push({
            productId,
            quantity: Number(quantityElem.value),
            delivaryOptionId: '1'
        });
    }
    saveToStorage();
}

export function removeFromCart(productId) {
    cart = cart.filter((cartItem) => {
        return cartItem.productId != productId;
    });
    localStorage.setItem('cart', JSON.stringify(cart));

    saveToStorage();
}

export function updateQuanitty(productId, amnt) {
    cart = cart.map((cartItem) => {
        if (cartItem.productId === productId) {
            cartItem.quantity = amnt;
        }
        return cartItem;
    });
    saveToStorage();
}