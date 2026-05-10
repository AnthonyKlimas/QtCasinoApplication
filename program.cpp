#include <iostream>
#include <fstream>
#include <ctime>
#include <string>
#include "login.h"

using namespace std;


int main()
{ 
    int selection;
    int money = 0;
    int table;
    int spin;

srand(time(0));

//Login to user account
login();

//Keeps track of money with text file
ifstream infile("data/money.txt");

if(infile)
{
    infile >> money;
}

infile.close();

    cout << "Welcome to Docker Casino!" << endl;
    cout << "Your Balance is " << money << endl;

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
        money += 10;
    }else
    {
        cout << "You Lose!" << endl;
        money -= 10;
    }

    cout << "Your amount is " << money << endl;

    ofstream outfile("data/money.txt");

    outfile << money;

    outfile.close();

}