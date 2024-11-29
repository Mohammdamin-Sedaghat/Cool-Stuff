import { cart } from "./cart.js";
import { matchingDeliveryOption } from "./deliveryOptions.js";
import dayjs from 'https://unpkg.com/dayjs@1.11.10/esm/index.js';

export const orders = JSON.parse(localStorage.getItem('orders')) || [];

export function addOrder(order) {
    order.products.forEach((product, index) => {
        const matchingItem = matchingDeliveryOption(cart.at(index).delivaryOptionId);
        const today = dayjs();
        const delivaryDay = today.add(matchingItem.deliveryDays, 'days').format('MMMM D');
        product.estimatedDeliveryTime = delivaryDay;
    })
    orders.unshift(order);

    saveToStorage();
}

function saveToStorage() {
    localStorage.setItem('orders', JSON.stringify(orders))
}