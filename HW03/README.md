# Homework 03
### Cristian Stransky  
  
I included both the html file (just a quick fix to cstransky.com), tbe nginx 
configure file, and the systemd service file used to allow the page to start
automatically on start-up.  
  
The nginx configuration file is located in 
**nginx/sites-available/practice.nginx**  
The html file is located in **html/cstransky.com/index.html**  
The systemd service file is located in 
**systemd/system/practice\_app.service**  
The **elixir-practice-csstransky/** folder includes code originally forked from
Nat Tuck's [repo](https://github.com/NatTuck/elixir-practice). All the backend
for the homework 3 page is in this folder.  
  
Homework 03 website:  
**[hw03.cstransky.com](http://hw03.cstransky.com)**  
  
**Note:** For the "Arithmetic Expression" function on the website, it can only
evaluate functions properly that are divided by spaces.   
Example:  
	"2 + 3 * 4" == GOOD  
	"2+3*4" == FAIL  
  
**Note:** If you whatever reason, there are multiple numbers input into "Prime 
Factors", only the first number will be evaluated.  
Example:  
	"12 23 43 99" = [2, 2, 3]  
