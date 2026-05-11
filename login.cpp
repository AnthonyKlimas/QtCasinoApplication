#include <iostream>
#include <fstream>
#include <string>
#include "mysql_connector.h"

using namespace std;

void createLogin();
void signIn(string&, string&, float&);

void login(string& username, string& password, float& balance)
{
    int choice;

        cout << "Login or Sign Up?" << endl;
        cout << "Login = (0) | Sign Up = (1)" << endl;
        cin >> choice;

        while(choice != 1 && choice != 0)
        {
            cin >> choice;
        }
        if(choice == 1)
        {
            createLogin();
            signIn(username, password, balance);

        } else
        {
            signIn(username, password, balance);
            
        }


}

void createLogin()
{
    string user;
    string pass;

    cout << "Create Username: ";
    cin >> user;

    cout << "Create Password: ";
    cin >> pass;

    cout << "Username and Password have been created!" << endl;

    writetoDatabase(user, pass, 100.50);

}

void signIn(string& inputUsername, string& inputPassword, float& bal)
{

    while(true)
    {

        cout << "Input username: " << endl;
        cin >> inputUsername;

        cout << "Input password: " << endl;
        cin >> inputPassword;

        readtoDatabase(inputUsername, inputPassword, bal);

            if(readtoDatabase(inputUsername, inputPassword, bal))
            {
                cout << "Login Successful!" << endl;
                break;
            
            }else
            {
                cout << "Username or Password is incorrect\nTry Again!" << endl;
            }

    }
}