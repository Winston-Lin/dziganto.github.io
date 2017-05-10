---
published: true
categories: [Anaconda, Shiro, Spark, Zeppelin, ZeppelinHub]
title: How To Install & Configure Zeppelin Locally
---

![EMR](/assets/images/zeppelin.jpg?raw=true){: .center-image }

# About
Apache Zeppelin is:
>A web-based notebook that enables interactive data analytics. You can make beautiful data-driven, interactive and collaborative documents with SQL, Scala and more.

In this tutorial I am going to show you how to setup Zeppelin locally. Specifically, I will show you step-by-step how to: 
1. Download & Unpack Zeppelin
2. Check That Spark Is Setup Correctly
2. Connect Anaconda & Zeppelin (Optional)
2. Setup Shiro Authentication 
3. Setup/Configure ZeppelinHub

# Assumptions
In order to keep this tutorial short, I am going to assume you already did the following:
- Installed [Anaconda w/Python 3](https://www.continuum.io/downloads)
- Installed Java, Scala, and Apache Spark (see [this](https://medium.com/@josemarcialportilla/installing-scala-and-apache-spark-on-mac-os-837ae57d283f) tutorial for help)

I also assume you have basic familiarity with bash.

Code that you should copy will look like this:  
```
$ only copy text after the dollar sign
```

# Download & Unpack Zeppelin
1. Navigate to [Zeppelin downloads](http://zeppelin.apache.org/download.html).
2. Click on the blue box called **zeppelin-0.7.1-bin-all.tgz**. This will take you to a list of download mirrors.
3. Choose one of the links. I used the first one but any should work.
4. Move the downloaded tgz file from **Downloads** to **home** by typing:
```
$ mv ~/Downloads/zeppelin-0.7.1-bin-all.tgz ~
```
5. Navigate to your home directory if you are not already there.
6. Tar the package by typing:
```
$ tar -xzvf zeppelin-0.7.1-bin-all.tgz
```
7. Zeppelin is now downloaded and unpacked. 
8. You can check that it was successful by doing two things.
9. First, type this:
```
$ cd zeppelin-0.7.1-bin-all
$ bin/zeppelin-daemon.sh start
```
10. Then, click this link: **http://localhost:8080/**.
11. Zeppelin should fire right up.

# Check That Spark Is Setup Correctly
1. In Zeppelin, click **Create new note**.
2. A new window will open. Either keep the default *Note Name* or choose something you like. Leave **spark** as the *Default Interpreter*. Click **Create Note**.
3. In the first box (called a paragraph), type **sc**.
4. Press play button or hit **Shift+Enter**.
5. This takes a few seconds so be patient. Everything is working properly if you get output that looks something like 
>**res0: org.apache.spark.SparkContext = org.apache.spark.SparkContext@356639d8**.
6. If you get an error in Step 5, Spark is not configured properly. Best go fix it now.

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
%python
print(sys.version)
```

# Setup Shiro Authentication
1. In your Terminal window, navigate to **~/zeppelin-0.7.1-bin-all/conf**.
2. We need to copy three templates:
```
$ sudo cp shiro.ini.template shiro.ini
$ sudo cp zeppelin-site.xml.template zeppelin-site.xml
$ sudo cp zeppelin-env.sh.template zeppelin-env.sh
```  
3. We need to change authentication from *anonymous* to *username* and *password*:
```
$ sudo nano shiro.ini
```
4. Scroll down to the [urls] section. 
5. Make sure it looks like this:  
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
11. Navigate to Zeppelin home directory by typing:
```
$ cd ..
```
12. We need to restart Zeppelin so type:
```
$ sudo bin/zeppelin-daemon.sh restart
```
13. Go back to your Zeppelin notebook in your browser.
14. Refresh the page. You should see **Login** towards the top right with a green dot to the left of it.
15. Click **Login**.
16. Use any of these **username** and **password** combos:
```
admin password1
user1 password2
user2 password3
```  
*Note 1: usernames, passwords, and groups can be setup in **shiro.ini** file.*

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
$ cd ~/zeppelin-0.7.1-bin-all/conf
$ nano zeppelin-env.sh
```
10. Scroll down to ZeppelinHub section and add this code:  
```    
export ZEPPELIN_NOTEBOOK_STORAGE="org.apache.zeppelin.notebook.repo.VFSNotebookRepo, org.apache.zeppelin.notebook.repo.zeppelinhub.ZeppelinHubRepo"
export ZEPPELINHUB_API_ADDRESS="https://www.zeppelinhub.com"
export ZEPPELINHUB_API_TOKEN="YOUR_TOKEN_STRING"
export ZEPPELINHUB_USER_KEY="YOUR_USER_KEY" (if authenticating)
```
10. Navigate to Zeppelin home directory by typing:
```
$ cd ..
```  

11. We need to restart Zeppelin again so type: 

```
$ bin/zeppelin-daemon.sh restart
```  
12. Reload *ZeppelinHub* page.
13. You know it worked if you click on your instance and your notebooks show up in the pane to the right.
14. Congrats! You have installed and configured Zeppelin on your local machine.

---

As always, I hope you found this tutorial helpful. 

If you are new to Zeppelin and wondering "what can I do with it?", stay tuned because I'm working on a Zeppelin tutorial that will showcase its many uses.

---
P.S. If you found any errors, I would love to hear about it.
