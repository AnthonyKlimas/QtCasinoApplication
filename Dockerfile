FROM gcc:latest

RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    libmysqlcppconn-dev

WORKDIR /app

COPY . .

# RUN g++ MySQL_Test.cpp -lmysqlcppconn -o casino
RUN g++ program.cpp login.cpp mysql_connector.cpp -lmysqlcppconn -o casino
