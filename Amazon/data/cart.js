export const cart = [
    {
        productId: "e43638ce-6aa0-4b85-b27f-e1d07eb678c6",
        quantity: 1
    }, {
        productId: "15b6fc6f-327a-4ec4-896f-486349e85a3d",
        quantity: 3
    }
];

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