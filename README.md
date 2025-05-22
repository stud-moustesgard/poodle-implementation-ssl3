# poodle-implementation-ssl3

installing vncviewer for victim web browser: tigervnc viewer  
apt-get install tigervnc-standalone-server  
apt-get install tigervnc-viewer  

go into the webserver directory -> run ./launch.sh  

go into the attacker directory -> run ./launch.sh -> enter "passive" into the console    

go into the victim directory -> run ./launch.sh -> open a new terminal tab -> enter vncviewer 127.0.0.1:5900 -> enter the password -> open the developer console in the web browser and go to the console tab -> in the web browser enter the URL: https://vulnerable.local:4444/ -> in the web browser add exception for the self signed certificate so you can access the webpage  -> this will greet you with a default html page with javascript for the poodle attack  

the attacker console should inform that it received a packet -> do enter and then run the command "search" in the attacker console -> it will say waiting for data.... findlengthblock() -> enter findlengthblock() into the victims web browsers console -> the attacker console will print the size and inform about the mode. in this case it prints "CBC block size 8" -> press enter in the attacker console again and now run the command "active" in it -> it tells it will wait for sendAttack() -> run sendAttack() in the victims web browsers console -> the attacker console will start printing requests that its sending and how many blocks it may have processed, for example 1/70 where it will print the cookie "secret_data=hello world its 2025" which is a part of the nginx.conf in the web server.

