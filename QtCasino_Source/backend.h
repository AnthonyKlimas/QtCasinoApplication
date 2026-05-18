#ifndef BACKEND_H
#define BACKEND_H

#include "../blackjack.h"
#include "../cards.h"
#include "../mysql_connector.h"
#include <QString>
#include <QObject>

//Creates backend class that inheris all of the objects from base class QObject
class backend : public QObject
{
    //Used so QT works dynamically
    Q_OBJECT

private:
    Blackjack game;

public:
    explicit backend(QObject *parent = nullptr);

    Q_INVOKABLE bool login(QString username, QString password);

    Q_INVOKABLE bool signup(QString username, QString password);

    Q_INVOKABLE void startBlackjack();

    Q_INVOKABLE void playerHit();

    Q_INVOKABLE QString getWinner();

    Q_INVOKABLE void shuffleDeck();

    Q_INVOKABLE void dealerTurn();

    Q_INVOKABLE void createDeck();

    Q_INVOKABLE Card dealCard();

    Q_INVOKABLE int calcScore(std::vector<Card>&);

    Q_INVOKABLE bool playerBust();

    Q_INVOKABLE bool dealerBust();

    Q_INVOKABLE std::vector<Card>& getPlayerHand();

    Q_INVOKABLE std::vector<Card>& getDealerHand();

    Q_INVOKABLE int getPlayerScore();

    Q_INVOKABLE int getDealerScore();

    Q_INVOKABLE QString getPlayerCardImage(int index);

    Q_INVOKABLE QString getDealerCardImage(int index);

    Q_INVOKABLE float getBalance(QString username, QString password);

    Q_INVOKABLE bool editBalance(QString username, float bal);
};

#endif // BACKEND_H
