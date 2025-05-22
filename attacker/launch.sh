sudo docker stop poodle-attacker
sudo docker rm poodle-attacker

sudo docker build -t attacker .
sudo docker run -it -p 1337:1337 --name poodle-attacker attacker
