let compChoice = Math.random();
let score = {
    wC: 0,
    lC: 0,
    tC: 0
};

function CheckWinner(userChoice) {
    compChoice = Math.random();
    document.getElementById("gameState").style = "visibility: visible;"
    if (compChoice <= 1/3) {
        if (userChoice <= 1/3) {
            score.tC += 1;
            document.getElementById("status").innerHTML = "Tie";
        } else if (userChoice <= 2/3) {
            score.wC += 1;
            document.getElementById("status").innerHTML = "You Win";
        } else {
            score.lC += 1;
            document.getElementById("status").innerHTML = "You Lose";
        }
        document.getElementById("compEmoji").src = "rock-emoji.png";
    } else if (compChoice <= 2/3) {
        if (userChoice <= 1/3) {
            score.lC += 1;
            document.getElementById("status").innerHTML = "You Lose"
        } else if (userChoice <= 2/3) {
            score.tC += 1;
            document.getElementById("status").innerHTML = "Tie"
        } else {
            score.wC += 1;
            document.getElementById("status").innerHTML = "You Win"
        }
        document.getElementById("compEmoji").src = "paper-emoji.png";
    } else {
        if (userChoice <= 1/3) {
            score.wC += 1;
            document.getElementById("status").innerHTML = "You Win"
        } else if (userChoice <= 2/3) {
            score.lC += 1;
            document.getElementById("status").innerHTML = "You Lose"
        } else {
            score.tC += 1;
            document.getElementById("status").innerHTML = "Tie"
        }
        document.getElementById("compEmoji").src = "scissors-emoji.png";
    }
    if (userChoice <= 1/3) {
        document.getElementById("userEmoji").src = "rock-emoji.png"
    } else if (userChoice <= 2/3) {
        document.getElementById("userEmoji").src = "paper-emoji.png"
    } else {
        document.getElementById("userEmoji").src = "scissors-emoji.png"
    }
    document.getElementById("wlt").innerHTML = `Wins: ${score.wC},Losses: ${score.lC},Ties: ${score.tC}`;
}

function resetScore() {
    score.wC = 0;
    score.lC = 0;
    score.tC = 0;
    document.getElementById("gameState").style = "visibility: hidden;"
    document.getElementById("wlt").innerHTML = `Wins: ${score.wC},Losses: ${score.lC},Ties: ${score.tC}`;
}

let isPlaying = false;
let autoPlayer;
function autoPlay() {
    let warning = document.querySelector('.warning-js');
    if (!isPlaying){
        autoPlayer = setInterval(() => {
            CheckWinner(Math.random())
        }, 500);
        warning.style.visibility = "visible";
    } else {
        clearInterval(autoPlayer);
        warning.style.visibility = "hidden";
    }
    isPlaying = !isPlaying;
}