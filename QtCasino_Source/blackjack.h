#ifndef BLACKJACK_H
#define BLACKJACK_H

#include <vector>
#include <string>


struct Card
{
    std::string suit;
    std::string rank;
    int value;

};

class Blackjack
{

    private:
        std::vector<Card> deck;

        std::vector<Card> playerHand;

        std::vector<Card> dealerHand;

    public:

        void shuffleDeck();

        void playerHits();

        void dealerTurn();

        void createDeck();

        Card dealCard();

        void startGame();

        int calculateScore(std::vector<Card>& hand);

        bool playerBust();

        bool dealerBust();

        std::string determineWinner();

        std::vector<Card>& getPlayerHand();

        std::vector<Card>& getDealerHand();

        int getPlayerScore();

        int getDealerScore();

};


#endif