Setup
-----

Install RVM
  see https://rvm.beginrescueend.com/rvm/install/

Install Ruby 1.9.3
    rvm install ruby-1.9.3-p125

Install memcached
  Using brew
  $ brew install memcached

  Using Mac Port
  $ sudo port install memcached

Install MySql
  $ brew install mysql

Checkout the source
  $ git@github.com:ktruong248/sinatra-auth-service.git
  $ cd sinatra-auth-service
  $ gem install bundler
  $ bundle install

Install mysql database

 Login to mysql with admin account then run sqls

create database api_account;
use api_account;

CREATE USER 'auth-service'@'localhost' IDENTIFIED BY 'auth-service-password';
GRANT ALL PRIVILEGES ON *.* TO 'auth-service'@'localhost' WITH GRANT OPTION;

CREATE USER 'auth-service'@'%' IDENTIFIED BY 'auth-service-password';
GRANT ALL PRIVILEGES ON *.* TO 'auth-service'@'%' WITH GRANT OPTION;


CREATE TABLE IF NOT EXISTS accounts (
  id VARCHAR(20) PRIMARY KEY,
  password VARCHAR(20),
  description VARCHAR(80),
  created_at TIMESTAMP,
  modified_at TIMESTAMP
);

INSERT INTO accounts (id, password, description, created_at, modified_at) values ( 'my-app-id', 'password', 'sample api account', now(), now() );


  # start up web server
  $ shotgun


#
# create new token for scope "some_uri"
#
$ curl "http://localhost:9393/auth/v1/access_token?client_id=my-app-id&client_secret=password&scope=some_uri"

#
# validate the token
#
$ curl "http://localhost:9393/auth/v1/validate?access_token=<token return from above command>&scope=some_uri"

Extra:
  If you encounter error like "Library not loaded: libmysqlclient.18.dylib" during runtime.Please do
  $ sudo ln -s /usr/local/mysql/lib/libmysqlclient.18.dylib /usr/lib/libmysqlclient.18.dylib