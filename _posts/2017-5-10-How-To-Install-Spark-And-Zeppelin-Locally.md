---
published: true
categories: [Anaconda, Shiro, Spark, Zeppelin, ZeppelinHub]
title: How To Install & Configure Spark & Zeppelin Locally
---

![EMR](/assets/images/zeppelin.jpg?raw=true){: .center-image }

# About
Apache Zeppelin is:
>A web-based notebook that enables interactive data analytics. You can make beautiful data-driven, interactive and collaborative documents with SQL, Scala and more.

In this tutorial I am going to show you how to easily setup Apache Spark and Zeppelin locally. Specifically, I will show you step-by-step how to: 
1. Install Homebrew
2. Install Spark & Its Dependencies
3. Install Zeppelin
4. Run Zeppelin
5. Test Spark, PySpark, & Python Interpreters
6. Setup Shiro Authentication 
7. Setup ZeppelinHub

# Assumptions
In order to keep this tutorial short, I am going to assume the following:
- You are familiar with bash
- You already have Xcode installed on your Mac (see App store)
- You run all commands from your *home* directory
- You already Installed [Anaconda w/Python < 3.6](https://www.continuum.io/downloads) 
>note: PySpark doesn't play nicely w/Python 3.6; any other version will work fine.


Code that you should copy will look like this:  
```
$ only copy text after the dollar sign
```

# Install Homebrew
Homebrew is great because it will automatically take care of almost all the requisite setup for you. I found this to be the easiest install method. 
1. Copy and paste this command into Terminal:
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

# Install Spark & Its Dependencies
1. Copy and paste these commands into Terminal:
```
$ brew cask install java
$ brew install scala
$ brew install apache-spark
```
# Install Zeppelin
1. Copy and paste this command into Terminal:
```
$ brew install apache-zeppelin
```

# Run Zeppelin
We need to start the Zeppelin daemon.  
1. Copy and paste this into Terminal:
```
$ zeppelin-daemon.sh start
```
2. Click this [link](http://localhost:8080) or open any browswer and type:
```
http://localhost:8080
```
Zeppelin should fire right up.

# Test Spark, PySpark, & Python Interpreters
1. In Zeppelin, click **Create new note**.
2. A new window will open. Either keep the default *Note Name* or choose something you like. Leave **spark** as the *Default Interpreter*. Click **Create Note**.
3. In the first box (called a paragraph), type **sc**.
4. Press play button or hit **Shift+Enter**.
5. This takes a few seconds so be patient. Everything is working properly if you get output that looks something like 
>**res0: org.apache.spark.SparkContext = org.apache.spark.SparkContext@356639d8**.
6. If you get an error in Step 5, Spark is not configured properly. Best go fix it now.
7. In a separate paragraph, type this:
```
%pyspark
import numpy as np
np.arange(10)
```
>*If you get an error or a message that says PySpark is not responding, something is wrong with your configuration or **metastore_db**. You better go fix that.*  
8. In yet another paragraph, type:
```
%python
import numpy as np
np.arange(8)
```
>*No issues means everything is working properly. Feel free to test other modules at this time.*

# Connect Anaconda & Zeppelin (Optional)
*Note: this step is only necessary if Anaconda is not set as your default python interpreter. I did not have to set this locally myself but I am including the steps in case you need them.* 

1. In Zeppelin, click **anonymous** in top right corner.
2. Click **Interpreter**.
3. Scroll down to python interpreter.
4. Click **Edit** button in top right of python interpreter box.
5. Locate **zeppelin.python**.
6. Set value to path where your Anaconda is located.
7. All set!

*Note: You can check by typing this into a new paragraph and running:* 
```
%sh
python --version
```

# Setup Shiro Authentication
1. In your Terminal window, navigate to **/usr/local/Cellar/apache-zeppelin/0.7.1/libexec/conf**.
2. We need to copy three templates by copying and pasting these commands:
```
$ sudo cp shiro.ini.template shiro.ini
$ sudo cp zeppelin-site.xml.template zeppelin-site.xml
$ sudo cp zeppelin-env.sh.template zeppelin-env.sh
```  
3. We need to change authentication from *anonymous* to *username* & *password*:
```
$ sudo nano shiro.ini
```
4. Scroll down to the [urls] section. 
5. Make sure it looks exactly like this:  
```
#/api/version = anon
/api/interpreter/** = authc, roles[admin]
/api/configurations/** = authc, roles[admin]
/api/credential/** = authc, roles[admin]
#/** = anon 
/** = authc
```
6. Save changes and exit nano.
7. Now that you are back in bash, type:
```
$ sudo nano zeppelin-site.xml
```
8. Locate **zeppelin.anonymous.allowed**.
9. Set its value to **false**.
10. Save changes and exit nano.
11. Navigate to your home directory by typing:
```
$ cd
```
12. We need to restart Zeppelin so type:
```
$ zeppelin-daemon.sh restart
```
13. Go back to the Zeppelin notebook in your browser.
14. A window should pop up asking for username and password.
15. Use any of these **username** and **password** combos:
```
admin password1
user1 password2
user2 password3
```  
>*Note: usernames, passwords, and groups can be setup in **shiro.ini** file.*

# Setup ZeppelinHub
1. Go to [ZeppelinHub](https://www.zeppelinhub.com/)
2. Click blue **Register** button.
3. Fill out form and agree to *Terms of Service* and *Privacy Policy*
4. On the ZeppelinHub dashboard, locate **Zeppelin Instances** and click the **+** to the right.
5. Type an instance name and a brief description.
6. If you setup Shiro authentication, click **Include Zeppelin Credentials** and add **username** and **password**.
7. Copy **token** (and **user key** if authenticating).
8. Close window.
9. You need to set some environment variables:
```
$ cd /usr/local/Cellar/apache-zeppelin/0.7.1/libexec/conf
$ nano zeppelin-env.sh
```
10. Scroll down to ZeppelinHub section and add this code:  
```    
export ZEPPELIN_NOTEBOOK_STORAGE="org.apache.zeppelin.notebook.repo.VFSNotebookRepo, org.apache.zeppelin.notebook.repo.zeppelinhub.ZeppelinHubRepo"
export ZEPPELINHUB_API_ADDRESS="https://www.zeppelinhub.com"
export ZEPPELINHUB_API_TOKEN="YOUR_TOKEN_STRING"
export ZEPPELINHUB_USER_KEY="YOUR_USER_KEY" (if authenticating)
```
10. Navigate to your home directory by typing:
```
$ cd
```  

11. We need to restart Zeppelin again so type: 

```
$ zeppelin-daemon.sh restart
```  
12. Reload *ZeppelinHub* page.
13. You know it worked if you click on your instance and your notebooks show up in the pane to the right.
14. Congrats! You have installed and configured Apache Spark & Zeppelin on your local machine.

---

As always, I hope you found this tutorial helpful. 

If you are new to Zeppelin and wondering "what can I do with it?", stay tuned because I'm working on a Zeppelin tutorial that will showcase its many uses.

---
P.S. If you found any errors, I would love to hear about it.
