#ifndef MYSQL_CONNECTOR_H
#define MYSQL_CONNECTOR_H

#include <string>
#include <mysql_driver.h>
#include <mysql_connection.h>

//function defintions
sql::Connection* database();
void writetoDatabase(std::string, std::string, float);
bool readtoDatabase(std::string, std::string, float&);
void editbalanceDatabase(std::string, float);

#endif