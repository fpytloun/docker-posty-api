Installation
============

Install MySQL server container
   .. code-block:: bash

      docker run --name mysql-server -e MYSQL_ROOT_PASSWORD=root -d mysql

Create posty database
    .. code-block:: bash

       docker run -it --link mysql-server:mysql --rm mysql sh -c 'exec mysql -hmysql-server -uroot -proot -e"CREATE DATABASE posty;"'

Run posty-api
    .. code-block:: bash

       docker run --name posty-api --link mysql-server:mysql -d posty-api

Tweaks
======

Create MySQL user for posty
---------------------------

Run MySQL shell
    .. code-block:: bash

       docker run -it --link mysql-server:mysql --rm mysql sh -c 'exec mysql -hmysql-server -uroot -proot"'

Create user and database
   .. code-block:: mysql

      CREATE USER 'posty'@% IDENTIFIED BY 'random_password';
      CREATE DATABASE `posty`;
      GRANT ALL PRIVILEGES ON `posty`.* TO 'posty'@%;
      FLUSH PRIVILEGES;

Run container and submit database informations
    .. code-block:: bash

       docker run --name posty-api --link mysql-server:mysql -e DB_USER=posty -e DB_PASSWORD=random_password -d posty-api
