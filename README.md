# ft_server
This project is intended to introduce you to the basics of system and network administration. It will allow you to install a complete web server, using a deployment technology named Docker.

**Subject:**

Constraints are as follows:
- You must set up a web server with Nginx, in only on edocker container. The container OS must be debain buster.
- You web server must be able to run several services at the same time. The srvices will be a WordPress website, phpMyadmin and Mysql. You will need to make sure your SQL database works with the Wordpress and phpmyadmin.
- You server should be able to use the SSL protocol
- You will also need to make sure your server is running with an index that must be able to be disabled.

**Usage:**
Type the following in terminal to build and run:
```
git clone https://github.com/avan-dam/ft_server.git
cd ft_server
docker build -t ft_server .
docker run -it -p 80:80 -p 443:443 ft_server
```
To stop all containers, images, and cache run the following command:
```
docker system prune -a
```

**To Access:**

To go to wordpress put this address in browser
```
https://localhost
```
<img width="942" alt="Screenshot 2021-07-01 at 15 01 30" src="https://user-images.githubusercontent.com/61982496/124129519-24056580-da7e-11eb-966e-5f7994ae56a5.png">

To go to php put this address in browser

username: username

password: password

```
https://localhost/phpmyadmin
```


<img width="843" alt="Screenshot 2021-07-01 at 15 07 41" src="https://user-images.githubusercontent.com/61982496/124129497-1ea81b00-da7e-11eb-903a-880376ac798f.png">

