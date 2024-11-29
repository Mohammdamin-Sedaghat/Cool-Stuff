export let cart = JSON.parse(localStorage.getItem('cart')) || [];

function saveToStorage() {
    localStorage.setItem('cart', JSON.stringify(cart));
}

export function addToCart(productId, quantity) {
    //getting the quantity.
    
    let isIn = false;
    cart.forEach((cartItem) => {
        if (cartItem.productId === productId) {
            cartItem.quantity += Number(quantity);
            isIn = true;
        }
    });
  
    //making sure we are only updating the quanity for elements already in the cart. 
    if (!isIn) {
        cart.push({
            productId,
            quantity: Number(quantity),
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

export function updateDeliveryOptionId(productId, value) {
    cart.forEach((cartItem)=> {
        if (cartItem.productId === productId) {
            cartItem.delivaryOptionId = value;
        }
    });
    saveToStorage();
}

//Function to update the quanity of the cart (top right corner)
export function updateCartQuantityHTML() {
    const quantityElement = document.querySelector('.cart-quantity-js');
    let total = 0;
    cart.forEach((cartItem) => {
        total += cartItem.quantity;
    });
    quantityElement.innerHTML = total;
}