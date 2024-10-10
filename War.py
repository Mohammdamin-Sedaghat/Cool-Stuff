import random
suits = ("Hearts","Diamonds", "Spades", "Clubs")
ranks = ("Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace")
values = {'Two': 2, 'Three': 3, 'Four': 4, 'Five': 5, 'Six': 6, 'Seven': 7, 'Eight': 8, 'Nine': 9, 'Ten': 10, 'Jack': 11, 'Queen': 12, 'King': 13, 'Ace': 14}

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

    def __init__(self, name):
        self.name = name
        self.all_cards = []

    def remove_one(self):
        return self.all_cards.pop(0)

    def add_cards(self, new_cards):
        if type(new_cards) == type([]):
            self.all_cards.extend(new_cards)
        else:
            self.all_cards.append(new_cards)

    def __str__ (self):
        return f'Player {self.name} has {len(self.all_cards)} cards.'

player_one = Player("One")
player_two = Player("Two")

new_Deck = Deck()
new_Deck.shuffle()

for num in range(26):
    player_one.add_cards(new_Deck.deal_one())
    player_two.add_cards(new_Deck.deal_one())

gameOn = True
roundNum = 0

while gameOn:

    roundNum += 1
    print(f"Round {roundNum}")
    if len(player_one.all_cards) == 0:
        print("Player One, out of cards! Player Two Wins!")
        gameOn = False
        break

    if len(player_two.all_cards) == 0:
        print("Player Two, out of cards! Player Two Wins!")
        gameOn = False
        break

    #Start a new round
    player_one_cards = []
    player_one_cards.append(player_one.remove_one())

    player_two_cards = []
    player_two_cards.append(player_two.remove_one())

    #Checking if in war
    war_on = False
    if player_one_cards[-1].value > player_two_cards[-1].value:
        player_one.add_cards(player_one_cards)
        player_one.add_cards(player_two_cards)
    elif player_one_cards[-1].value < player_two_cards[-1].value:
        player_two.add_cards(player_one_cards)
        player_two.add_cards(player_two_cards)
    else:
        war_on = True
    while war_on:
        if len(player_one.all_cards) < 6:
            print("Player One does not have enough cards to participate in war. Player Two has Won!")
            war_on = False
            gameOn = False
            break
        elif len(player_two.all_cards) < 6:
            print("Player Two does not have enough cards to participate in war. Player One has Won!")
            war_on = False
            gameOn = False
            break

        for item in range(6):
            player_one_cards = []
            player_one_cards.append(player_one.remove_one())

            player_two_cards = []
            player_two_cards.append(player_two.remove_one())

        if player_one_cards[-1].value > player_two_cards[-1].value:
            player_one.add_cards(player_one_cards)
            player_one.add_cards(player_two_cards)
            print("Player One has won the war!")
            war_on = False
            break
        elif player_one_cards[-1].value < player_two_cards[-1].value:
            player_two.add_cards(player_one_cards)
            player_two.add_cards(player_two_cards)
            print("Player Two has won the war!")
            war_on = False
            break
        else:
            print("War was not resolved. Moving to next round of war.")