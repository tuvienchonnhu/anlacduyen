anlacduyen (for java 1.8 +)
-------------------

Java e-commerce software

- Headless commerce
- Shopping cart
- Catalogue
- Search
- Checkout
- Administration
- REST API


Get the code:
-------------------
Clone the repository:
     
	 $ git clone git://github.com/tuvienchonnhu/anlacduyen.git
	 

If this is your first time using Github, review http://help.github.com to learn the basics.

You can also download the zip file containing the code from https://github.com/tuvienchonnhu/anlacduyen 

To build the application:
-------------------	
From the command line:

	$ cd anlacduyen
	$ mvnw clean install
	

Run the application from Tomcat 
-------------------
copy sm-shop/target/ROOT.war to tomcat or any other application server deployment dir

Increase heap space to 1024 m

### Heap space configuration in Tomcat:


If you are using Tomcat, edit catalina.bat for windows users or catalina.sh for linux / Mac users

	in Windows
	set JAVA_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=256m" 
	
	in Linux / Mac
	export JAVA_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=256m" 

Run the application from Spring boot 
-------------------

       $ cd sm-shop
       $ mvnw spring-boot:run

Run the application from Spring boot in eclipse
-------------------

Right click on com.salesmanager.shop.application.ShopApplication

run as Java Application

Run the application from Spring boot in IntelliJ
-------------------

In Run/Debug Configurations, set to the option Working directory the path of the sm-shop project

run ShopApplication



### Access the application:
-------------------

Access the deployed web application at: http://localhost:8080/

Access the admin section at: http://localhost:8080/admin

username : anlacduyen01@gmail.com

password : password

The instructions above will let you run the application with default settings and configurations.
Please read the instructions on how to connect to MySQL, configure an email server and configure other subsystems


### Documentation:
-------------------

Documentation available <http://documentation.shopizer.com>



