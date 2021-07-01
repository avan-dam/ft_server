# ft_server
This project is intended to introduce you to the basics of system and network administration. It will allow you to install a complete web server, using a deployment technology named Docker.

**Subject:**

Constraints are as follows:
- You must set up a web server with Nginx, in only on edocker container. The container OS must be debain buster.
- You web server must be able to run several services at the same time. The srvices will be a WordPress website, phpMyadmin and Mysql. You will need to make sure your SQL database works with the Wordpress and phpmyadmin.
- You server should be able to use the SSL protocol
- You will also need to make sure your server is running with an index that must be able to be disabled.

**Usage:**
To build:

![Screenshot 2021-07-01 at 14 25 59](https://user-images.githubusercontent.com/61982496/124124054-472d1680-da78-11eb-80af-5a0282bc0ffa.png)

To run:
Type the dollowing in terminal
```
docker run -it -p 80:80 -p 443:443 ft_server
```
