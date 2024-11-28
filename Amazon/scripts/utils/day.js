let months = ["January", "February", "March", "April", "May","June", "July", "August", "September", "October", "November", "December"];

export function makeTimeBetter(time) {
    let month = months.at(Number(time.slice(5,7)) - 1);
    let day = Number(time.slice(8,10));
    return `${month} ${day}`;
}