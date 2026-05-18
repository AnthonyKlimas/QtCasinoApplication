#include <iostream>

//SQL libraries and C++ Connections
#include "mysql_connector.h"
using namespace std;

QSqlDatabase database()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");

    db.setHostName("127.0.0.1");
    db.setPort(3307);

    db.setDatabaseName("casino");

    db.setUserName("root");
    db.setPassword("AKsoccer47");

    if(!db.open())
    {
        qDebug() << "Database Error:" << db.lastError();

        qDebug() << "Driver Text:" << db.lastError().driverText();

        qDebug() << "Database Text:" << db.lastError().databaseText();
    }
    else
    {
        qDebug()
            << "Database connected!";
    }

    return db;
}

bool writetoDatabase(string username, string password, float balance)
{
    QSqlDatabase db = database();

    if(!db.isOpen())
    {
        return false;
    }

    QSqlQuery query;

    query.prepare("INSERT INTO users ""(username, password, balance) ""VALUES (:username, :password, :balance)");

    query.bindValue(
        ":username",
        QString::fromStdString(username)
    );

    query.bindValue(
        ":password",
        QString::fromStdString(password)
    );

    query.bindValue(
        ":balance",
        balance
    );

    if(!query.exec())
    {
        qDebug()
            << query.lastError().text();

        return false;
    }

    return true;
}

bool readtoDatabase(string username, string password)
{
    QSqlDatabase db = database();

    if(!db.isOpen())
    {
        return false;
    }

    QSqlQuery query;

    query.prepare("SELECT * FROM users " "WHERE username = :username " "AND password = :password");

    query.bindValue(
        ":username",
        QString::fromStdString(username)
    );

    query.bindValue(
        ":password",
        QString::fromStdString(password)
    );

    if(query.exec() && query.next())
    {
        return true;
    }

    return false;
}


bool editbalanceDatabase(string username, float bal)
{
    QSqlDatabase db = database();

    if(!db.isOpen())
    {
        return false;
    }

    QSqlQuery query;

    query.prepare("UPDATE users " "SET balance = :balance " "WHERE username = :username");

    query.bindValue(":balance", bal);

    query.bindValue(":username", QString::fromStdString(username));

    if(!query.exec())
    {
        qDebug()
            << query.lastError().text();

        return false;
    }

    return true;
}

float getbalanceDatabase(string username, string password)
{
    QSqlDatabase db = database();

    QSqlQuery query;

    query.prepare("SELECT balance FROM users " "WHERE username = :username " "AND password = :password");

    query.bindValue(":username", QString::fromStdString(username));

    query.bindValue(":password", QString::fromStdString(password));

    if(query.exec() && query.next())
    {
        return query.value(0).toFloat();
    }

    return false;

}

