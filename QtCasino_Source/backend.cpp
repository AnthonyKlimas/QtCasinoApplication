#include "backend.h"

using namespace std;



backend::backend(QObject *parent)
    : QObject{parent}
{



}

bool backend::login(QString username, QString password)
{
    float balance;

    return readtoDatabase(username.toStdString(), password.toStdString());

}

bool backend::signup(QString username, QString password)
{
    return writetoDatabase(username.toStdString(), password.toStdString(), 100.50);

}

//Start the blackjack game
void backend::startBlackjack()
{
    game.startGame();
}

//When player hits
void backend::playerHit()
{
    game.playerHits();
}

//Return the string of who won
QString backend::getWinner()
{
    return QString::fromStdString(game.determineWinner());
}

void backend::shuffleDeck()
{
    game.shuffleDeck();
}

void backend::dealerTurn()
{
    game.dealerTurn();
}

void backend::createDeck()
{
    game.createDeck();
}

Card backend::dealCard()
{
    return game.dealCard();
}

int backend::calcScore(std::vector<Card>& hand)
{
    return game.calculateScore(hand);
}

bool backend::playerBust()
{
    return game.playerBust();
}

bool backend::dealerBust()
{
    return game.dealerBust();
}

std::vector<Card>& backend::getPlayerHand()
{
    return game.getPlayerHand();
}

std::vector<Card>& backend::getDealerHand()
{
    return game.getDealerHand();
}

int backend::getPlayerScore()
{
    return game.getPlayerScore();
}

int backend::getDealerScore()
{
    return game.getDealerScore();
}

QString backend::getPlayerCardImage(int index)
{
    auto& hand = game.getPlayerHand();

    if(index >= hand.size())
    {
        return "";
    }

    return QString::fromStdString(getCardImagePath(hand[index]));
}

QString backend::getDealerCardImage(int index)
{
    auto& hand = game.getDealerHand();

    if(index >= hand.size())
    {
        return "";
    }

    return QString::fromStdString(getCardImagePath(hand[index]));
}

float backend::getBalance(QString username, QString password)
{
    return getbalanceDatabase(username.toStdString(), password.toStdString());
}

bool backend::editBalance(QString username, float bal)
{
    return editbalanceDatabase(username.toStdString(), bal);
}


























