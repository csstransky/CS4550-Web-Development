# Homework 03
### Cristian Stransky  
  
I included both the html file (just a quick fix to cstransky.me), tbe nginx 
configure file, and the systemd service file used to allow the page to start
automatically on start-up.  
  
The nginx configuration file is located in 
**nginx/sites-available/\<practice.nginx\>**  
The html file is located in **html/cstransky.me/\<index.html\>**  
The systemd service file is located in 
**systemd/system/\<practice\_app.service\>**  
  
Homework 03 website:  
[hw03.cstransky.me](http://hw03.cstransky.me)  
  
**Note:** For the "Arithmetic Expression" function on the website, it can only
evaluate functions properly that are divided by spaces.   
Example:  
	"2 + 3 * 4" == GOOD  
	"2+3*4" == FAIL  
  
**Note:** If you whatever reason, there are multiple numbers input into "Prime 
Factors", only the first number will be evaluated.  
Example:  
	"12 23 43 99" = [2, 2, 3]  
