export const cart = [];

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
            quantity: Number(quantityElem.value)
        });
    }
  };