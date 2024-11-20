let amount = 0;
let display = '';
let isOpBefore = true;


function calculate(val) {
    //making sure user doesn't type more than one op in a row
    if (typeof val === "string"){
        if (isOpBefore){
            return ;
        } else {
            isOpBefore = true;
        }
    } else {
        isOpBefore = false;
    }

    //adding the new user input to the display
    display += val;

    //checking if the element is too long to fit and change display accordingly
    const pElement = document.querySelector('p');
    pElement.innerHTML = display;
    if (pElement.scrollWidth > 250) {
        pElement.style.textAlign = "right";
        //making sure the overflowed content stays on the left
        pElement.scrollLeft = pElement.scrollWidth;   
        pElement.style.border = "solid 2px rgb(47, 47, 47)"          
    } else {
        pElement.style.textAlign = "left";
    }
}

function evaluateExp() {
    if (isOpBefore) {
        alert('did you forget something?');
        return ;
    }
    const res = eval(display);
    document.querySelector('p').innerHTML = res;
    display = `${res}`;
    if (document.querySelector('p').scrollWidth < 251) {
        document.querySelector('p').style.textAlign = "left";
    }
}

function clearFunc() {
    display = '';
    document.querySelector('p').innerHTML = ' ';
    isOpBefore = true;
}