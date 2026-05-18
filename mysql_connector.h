#ifndef MYSQL_CONNECTOR_H
#define MYSQL_CONNECTOR_H

#include <string>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariant>
#include <QDebug>
#include <QCoreApplication>

//function defintions
QSqlDatabase database();
bool writetoDatabase(std::string, std::string, float);
bool readtoDatabase(std::string, std::string);
bool editbalanceDatabase(std::string, float);
float getbalanceDatabase(std::string, std::string);

#endif