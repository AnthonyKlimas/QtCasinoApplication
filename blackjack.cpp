#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <random>
#include <ctime>
#include "blackjack.h"

using namespace std;

//Create 52 Card deck
void Blackjack::createDeck()
{
    deck.clear();

    vector<string> suits{"hearts", "diamonds", "clubs", "spades"};

    vector<string> ranks{"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};

    for(const auto& suit : suits)
    {
        for(int i = 0; i < ranks.size(); i++)
        {
            Card card;

            card.suit = suit;
            card.rank = ranks[i];

            if(i == 0)
            {
                
                card.value = 11;
            } else if(i >= 10)
            {
                card.value = 10;
            } else
            {
                card.value = i + 1;
            }

            deck.push_back(card);
        }
    }

}

void Blackjack::shuffleDeck()
{
    random_device rd;

    mt19937 generator(rd());

    shuffle(deck.begin(), deck.end(), generator);
}

Card Blackjack::dealCard()
{
    Card topCard = deck.back();

    deck.pop_back();

    return topCard;
}

void Blackjack::startGame()
{
    playerHand.clear();
    dealerHand.clear();

    if(deck.size() < 10)
    {
        createDeck();
        shuffleDeck();
    }

    playerHand.push_back(dealCard());
    dealerHand.push_back(dealCard());

    playerHand.push_back(dealCard());
    dealerHand.push_back(dealCard());


}

void Blackjack::playerHits()
    {
        playerHand.push_back(dealCard());
    }

void Blackjack::dealerTurn()
{
        dealerHand.push_back(dealCard());
    
}

int Blackjack::calculateScore(vector<Card>& hand)
{
    int total = 0;

    int aceCount = 0;

    for(Card& card : hand)
    {
        total += card.value;

        if(card.rank == "A")
        {
            aceCount++;
        }
    }

    while(total > 21 && aceCount > 0)
    {
        total -= 10;
        aceCount--;
    }

    return total;

}

bool Blackjack::playerBust()
{
    return calculateScore(playerHand) > 21;
}

bool Blackjack::dealerBust()
{
    return calculateScore(dealerHand) > 21;
}

string Blackjack::determineWinner()
{
    int playerScore = calculateScore(playerHand);

    int dealerScore = calculateScore(dealerHand);

    if(playerBust())
    {
    
         return "Dealer Wins";
    }

    if(dealerBust())
    {
        return "Player Wins";
    }

    if(playerScore > dealerScore)
    {
         return "Player Wins";
    }

    if(dealerScore > playerScore)
    {
        return "Dealer Wins";
    }

return "Push";
    
}

vector<Card>& Blackjack::getPlayerHand()
{
    return playerHand;
}

vector<Card>& Blackjack::getDealerHand()
{
        return dealerHand;
}

    
int Blackjack::getPlayerScore()
{
        return calculateScore(playerHand);
}

    
int Blackjack::getDealerScore()
{
        return calculateScore(dealerHand);
}