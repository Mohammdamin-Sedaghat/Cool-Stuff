import random
suits = ("Hearts","Diamonds", "Spades", "Clubs")
ranks = ("Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace")
values = {'Two': 2, 'Three': 3, 'Four': 4, 'Five': 5, 'Six': 6, 'Seven': 7, 'Eight': 8, 'Nine': 9, 'Ten': 10, 'Jack': 10, 'Queen': 10, 'King': 10, 'Ace': 1}

class Card:

    def __init__(self, suit, rank):
        self.suit = suit
        self.rank = rank
        self.value = values[rank]

    def __str__(self):
        return self.rank + " of " + self.suit

class Deck:

    def __init__(self):
        self.all_cards = []
        for suit in suits:
            for rank in ranks:
                self.all_cards.append(Card(suit, rank))

    def shuffle(self):
        random.shuffle(self.all_cards)

    def deal_one(self):
        return self.all_cards.pop()

class Player:

    def __init__(self, name = "dealer", money = 100):
        self.name = name
        self.all_cards = []
        self.total = 0
        self.money = money

    def add_cards(self, new_cards):
        self.all_cards.append(new_cards)
        self.total += new_cards.value

    def __str__ (self):
        return f'Player {self.name} has {len(self.all_cards)} cards.'

player = Player("One", 10)


game_on = True

while game_on:
    player.all_cards.clear()
    player.total = 0
    dealer = Player()

    new_Deck = Deck()
    new_Deck.shuffle()
    if player.money <= 0:
        print("Sorry you can not play. You do not have enough money.")
        game_on = False
        break
    bet = int(input("How much do you want to bet?  "))
    while bet > player.money or bet <= 0:
        print(f"Invalid input. Here is how much money you have: {player.money}")
        bet = int(input("How much do you want to bet?  "))

    cardOne = new_Deck.deal_one()
    cardTwo = new_Deck.deal_one()
    player.add_cards(cardOne)
    player.add_cards(cardTwo)
    print(f"\nThe dealer gave you {cardOne} and {cardTwo}. You now have a total of: {player.total}")
    cardOne = new_Deck.deal_one()
    cardTwo = new_Deck.deal_one()
    dealer.add_cards(cardOne)
    dealer.add_cards(cardTwo)
    print(f'The dealer has the card: {cardOne} and another card.')

    playerTurn = True
    dealerTurn = True
    while playerTurn:
        choice = ""
        while choice.lower() not in ["hit","stay"]:
            choice = input("\nDo you want to hit or stay?  ")

        if choice.lower() == "stay":
            print(f"You have chosen to stay. Your value is: {player.total}")
            playerTurn = False
            break
        else:
            cardOne = new_Deck.deal_one()
            player.add_cards(cardOne)
            print(f"You got the card: {cardOne}. making your total: {player.total}")
            if player.total > 21:
                print("You have been busted!")
                player.money -= bet
                playerTurn = False
                dealerTurn = False
                while choice.lower()[0] not in ["y", "n"]:
                    choice = input("\nDo you want to play again? (y/n) ")

                if choice == 'n':
                    game_on = False
                    break
                else:
                    break

    print(f"\nThe hidden card of the dealer was: {cardTwo}. Making his total: {dealer.total}")
    while dealerTurn:
        if dealer.total > player.total:
            print("The dealer has won the game!")
            player.money -= bet
            dealerTurn = False
            while choice.lower()[0] not in ["y", "n"]:
                choice = input("\nDo you want to play again? (y/n) ")

            if choice == 'n':
                game_on = False
                break
            else:
                break

        else:
            cardOne = new_Deck.deal_one()
            dealer.add_cards(cardOne)
            print(f"The dealer took the card: {cardOne}. Making his total: {dealer.total}")
            if dealer.total > 21:
                print(f"The dealer has busted! You win!")
                player.money += bet
                dealerTurn = False
                while choice.lower()[0] not in ["y", "n"]:
                    choice = input("\nDo you want to play again? (y/n) ")

                if choice == 'n':
                    game_on = False
                    break
                else:
                    break