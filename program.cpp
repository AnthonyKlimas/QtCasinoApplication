#include <iostream>
#include <fstream>
#include <ctime>
#include <string>
#include "login.h"
#include "mysql_connector.h"

using namespace std;

void black_jack(string, float&);


int main()
{ 

    float Balance;
    string Username;
    string Password;

srand(time(0));

//Login to user account
login(Username, Password, Balance);


    cout << "Welcome to Docker Casino!" << endl;
    cout << "Your Balance is " << Balance << endl;

    black_jack(Username, Balance);

}

void black_jack(string user, float& bal)
{
    float wager;
    int selection;
    int table;
    int spin;
    int playagain;



    while(true)
    {
        cout << "How much would you like to bet?" << endl;
        cin >> wager;
        if(wager > bal || wager <= 0)
        {
            cout << "Not a valid bet" << endl;
    
        } else
        {
            break;
        }
    }

    cout << "What will you select?" << endl;
    cout << "Select (1) = Black | Select (0) = Red" << endl;
    cin >> selection;

    if(selection == 1)
    {
        cout << "You chose Black!" << endl;
    } else
    {
        cout << "You chose Red!" << endl;
    }

    cout << "Press 1 to spin the wheel!" << endl;
    cin >> spin;
    table = rand() % 2;

    if(table == selection)
    {
        cout << "You Win!" << endl;
        bal += wager;
        editbalanceDatabase(user, bal);
    }else
    {
        cout << "You Lose!" << endl;
        bal -= wager;
        editbalanceDatabase(user, bal);
    }

    cout << "Your amount is " << bal << endl;

    cout << "Play Again?" << endl;
    cout << "Select (1) = Yes | Select (0) = No" << endl;
    cin >> playagain; 
    if(playagain == 1)
    {
        black_jack(user, bal);
    }


}