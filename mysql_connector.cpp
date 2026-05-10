#include <iostream>

//SQL libraries and C++ Connections
#include <mysql_driver.h>
#include <mysql_connection.h>
#include <cppconn/statement.h>
#include <cppconn/resultset.h>

using namespace sql;
using namespace mysql;
using namespace std;

Connection* database()
{
    //Creates Driver and Connection objects
    MySQL_Driver* driver;
    Connection* con;

    //Gets driver instance from connector library
    driver = get_mysql_driver_instance();

    //Connects to MySQL database server automatically
    con = driver->connect(
        "tcp://mysql-db:3306",
        "root",
        "AKsoccer47"
    );

    //Tells MySQL to use the casino database
    con->setSchema("casino");

    return con;

}

void writetoDatabase(string username, string password, int balance)
{
    //Creates Connection and statement objects
    Connection* con;
    Statement* stmt;

    //Uses casino database
    con = database();

    stmt = con->createStatement();

    //Creates string that is formatted correctly for Username, Password, and Balance to be inserted into database
    string query =
        "INSERT INTO users(username, password, balance) "
        "VALUES('" + username + "', '" +
        password + "', " +
        to_string(balance) + ")";

    //Inserts data into database
    stmt->execute(query);

    delete stmt;
    delete con;
}

bool readtoDatabase(string username, string password)
{
    ResultSet* res;
    Connection* con;
    Statement* stmt;

    con = database();

    stmt = con->createStatement();

    string query =
    "SELECT * FROM users "
    "WHERE username='" + username + 
    "' AND password = '" + password + "'";

res = stmt->executeQuery(query);

if(res->next())
{
    return true;
}
else
{
    return false;
}

delete res;
delete stmt;
delete con;


}
