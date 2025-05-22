sudo docker stop poodle-server
sudo docker rm poodle-server

sudo docker build -t sslv3-nginx .
sudo docker run -d --name poodle-server -p 4444:443 sslv3-nginx
