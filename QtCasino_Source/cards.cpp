#include "cards.h"
using namespace std;

string getCardImagePath(const Card& card)
{
 string rank = card.rank;
 string suit = card.suit;

 return "qrc:/cards/card_" + suit + "_" + rank + ".png";
}