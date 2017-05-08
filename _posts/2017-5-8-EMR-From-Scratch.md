---
published: true
title: Amazon EMR - From Anaconda To Zeppelin
---
![EMR](/assets/images/amazon_emr.png?raw=true){: .center-image }

# Motivation
Amazon EMR is described [here](https://aws.amazon.com/emr/) as follows:

>Amazon EMR provides a managed Hadoop framework that makes it easy, fast, and cost-effective to process vast amounts of data across dynamically scalable Amazon EC2 instances. You can also run these other popular distributed frameworks such as Apache Spark, HBase, Presto, and Flink in Amazon EMR, and interact with data in other AWS data stores such as Amazon S3 and Amazon DynamoDB.

>Amazon EMR securely and reliably handles a broad set of big data use cases, including log analysis, web indexing, data transformations (ETL), machine learning, financial analysis, scientific simulation, and bioinformatics.

In other words, if you use common big data Apache tools, you should seriously consider Amazon EMR because it makes the configuration process as painless as it can be. That's not to say it is always easy, though. 

Here is the list of big data Apache tools currently supported in EMR:

|       |         |       |       |
| ----- | ------- | ----- | ----- |
| Flink | Ganglia | Hadoop| HBase |
| HCatalog | Hive | Hue | Mahout|
| Oozie | Pig | Phoenix| Presto |
| Spark | Sqoop | Tez | Zeppelin | 
| ZooKeeper |

While Amazon has excellent documentation for basic setup and while there are several great tutorials online that cover a few aspects found in this tutorial, I had no luck finding a straightforward, sequential tutorial that allowed me to do all the things I wanted to do. In fact, many steps in this tutorial were discovered by yours truly after much trial and error. I am providing this partially as a reference for myself and partially in the hopes that my work will save you countless hours and moments of downright frustration. 

Here is what will be covered:
```
1.  Create S3 Bucket
2.  Create A Key Pair
3.  Create A Security Group
4.  Add Bootstrap Script To S3
5.  Create EMR Cluster w/Anaconda, Tensorflow, Theano, & Keras
6.  Setup FoxyProxy For Zeppelin
7.  Setup Zeppelin Notebook
8.  Set Anaconda As Default Python Interpreter In Zeppelin
9.  Setup Shiro Authentication in Zeppelin
10. Setup ZeppelinHub
```

# Assumptions
1. You already setup an AWS account. It also assumes your region is set appropriately.
2. Items in **bold** are buttons you click or data input into fields or code that you type. 
3. Items in *italics* are field names.
4. I include the dollar sign when I'm using the Terminal. Do not actually type the dollar sign, only the code that comes after.

Now on to the tutorial. Please follow the steps sequentially.

# Step 1: Create S3 Bucket
1. Sign in to the AWS Management Console and open the [Amazon S3 console](https://console.aws.amazon.com/s3/).
2. Click **Create bucket**. A new window will open.
3. Provide a name for you bucket under *Bucket name*. The name has to be unique and has to follow AWS guidelines. My bucket name for this demo is **standard-deviations-demo-bucket**.
4. Press the **Next** button located at the bottom right. 
5. For this demo, we will assume the default values for properties and permissions are just fine, so click the **Next** button two more times. This will take you to *Review*.
6. Press **Create bucket**
7. Congratulations, you have created an S3 bucket!

# Step 2: Create A Key Pair
1. Open the [Amazon EC2 console](https://console.aws.amazon.com/ec2/).
2. On the left-hand side there is a list that starts with *EC2 Dashboard*, *Events*, *Tags*, *Reports*, and so on. Look for the group titled *NETWORK & SECURITY*. Click the 4th option called *Key Pairs*.
3. Click **Create Key Pair**.
4. Enter a key pair name. I will use **standard-deviations-demo-key-pair** for this demo.
5. Click **Create**. 
6. Your private key file will automatically download. The base file name is the name you specified as the name of your key pair, and the file name extension is .pem. 
7. Save the private key file in a safe place. In practice, I move it to my *.ssh* directory. But to make this demo easier later on, I will move it to my *home* directory. Keep track of where you store your key. Use Finder to transfer the key or open Terminal and type **$ mv ~/Downloads/standard-deviations-demo-key-pair.pem ~**.
8. Still in Terminal, navigate to where your key is located. Again, I stored my key in my *home* directory so there is no need for me to change directories at this point. You will have to if you stored your key somewhere besides the *home* directory.
9. Use the following command to set the permissions of your private key file so only you can read it: **$ chmod 400 standard-deviations-demo-key-pair.pem**. You can check permissions with **ls -l**.
10. Tada! You now have a key pair setup so you can SSH into your EC2 nodes later on.

# Step 3: Create A Security Group
1. Open the Amazon [EC2 console](https://console.aws.amazon.com/ec2/).
2. On the left-hand side, look for the group titled *NETWORK & SECURITY*. Click the 1st option called **Security Groups**.
3. Click blue **Create Security Group** button.
4. Set *Security* group name* to **cluster_security_group**.
5. Set *description* to **keep the bad guys out**
6. The *inbound* tab should already be selected. If not, select it now.
7. Click **Add Rule**.
8. Select **SSH** from the dropdown.
9. Under *Source* there is a dropdown box that says *Custom*. Open the dropdown and select **MyIP**. This will automatically populate your IP address so only you will have access to your cluster.
10. Click the blue **Create** button on bottom right.
11. That's it. All done!

# Step 4: Add Bootstrap Script To S3
1. Copy or download my script called [emr_configs.sh](https://github.com/dziganto/dziganto.github.io/blob/master/_scripts/emr_configs.sh). 
2. Upload to the S3 bucket we created in Step 1 called **standard-deviations-demo-bucket**.

# Step 5: Create EMR Cluster w/Anaconda, Tensorflow, Theano, & Keras
1. Sign in to the AWS Management Console and open the [Amazon EMR console](https://console.aws.amazon.com/elasticmapreduce/).
2. Click **Create cluster**.
3. Click **Go to advanced options** at top.
4. We will use the latest EMR version which is 5.5.0. Select the software you want to install. For demo purpose, I will select **Hadoop 2.7.3**, **Spark 2.1.0**, and **Zeppelin 0.7.1**. Leave everything else as is.
5. Click blue **Next** button at bottom right.
6. Set the number of *Core* instances. I am using 1 so we have 1 Master and 1 Worker. You can change this after the cluster is created so don't worry if you change your mind later.
7. Click blue **Next** button at bottom right.
8. Input a name in the *Cluster name* field. I will use **Demo Cluster**.
9. Click the folder icon next to *S3 folder*. Select **standard-deviations-demo-bucket**.
10. Click blue **Select** button.
11. Expand *Bootstrap Actions* at bottom. Open dropdown called *Add bootstrap action*. Select **Custom action**. Click grey **Configure and add** button. 
12. New window opens. In the *Name* field I will use **emr bootstrap**. Select the folder to the right of **Script location** and update with **emr_configs.sh**. Click blue **Add** button. Window will close.
13. Click blue **Next** button at bottom right.
14. Click blue **Next** button at bottom right.
15. In *EC2 key pair*, open dropdown and select **standard-deviations-demo-key-pair**.
16. Expand *EC2 Security Groups* at middle bottom of page.
17. For *Master* use dropdown to select option ending in **(cluster_security_group)**.
18. For *Core & Task* use dropdown to select option ending in **(cluster_security_group)**.
19. Click blue **Create cluster** button at bottom right. 
20. A dashboard opens. It takes 10+ minutes for your cluster to do its thing so be patient. Your cluster is ready when your status reads *Waiting* in green.
21. Once your cluster is *Waiting*, locate *Master public DNS* on your dashboard. Click on the blue text that says **SSH** to the far right of that line.
22. A new window opens. Copy the command in the grey box from step 2.
23. Open Terminal.
24. Assuming your key is located in your *home* directory, paste this command as is and hit enter. *Note: if you moved your key, you will have to update the path to where your .pem file is located.*
25. You will get a message saying "The authenticity of host 'long host name' can't be established. Are you sure you want to continue connecting?" This is standard. Type **yes**.
26. You are successful if you see EMR spelled out in letters very large. 
27. All done. Nothing more to see here.

# Step 6: Setup FoxyProxy For Zeppelin
1. In Chrome, add the FoxyProxy Standard extension.
2. Restart Chrome after installing FoxyProxy.
3. Copy or download my script called [foxyproxy-settings.xml](https://github.com/dziganto/dziganto.github.io/blob/master/_scripts/foxyproxy-settings.xml). 
4. Upload to the S3 bucket we created in **Step 1: Create S3 Bucket**. 
5. Click on the **FoxyProxy icon** in the toolbar and select **Options**.
6. Click **Import/Export**.
7. Click **Choose File**, select **foxyproxy-settings.xml**, and click **Open**.
8. In the Import FoxyProxy Settings dialog, click **Add**.
9. Tutorial complete!

# Step 7: Setup Zeppelin Notebook
1. Navigate to the [Amazon EMR console](https://console.aws.amazon.com/elasticmapreduce/).
2. Locate *Master public DNS* on your dashboard. 
3. Click on the blue text that says **SSH** to the far right of that line.
4. A new window opens. Copy the command in the grey box from step 2.
5. Open Terminal.
6. Assuming your key is located in your *home* directory, paste this command as is and hit enter.  
*Note: if you moved your key, you will have to update the path to where your .pem file is located.*
7. Run the following commands in sequence:
```
$ cd /usr/lib/zeppelin
$ sudo bash bin/install-interpreter.sh -a 
$ sudo bash bin/zeppelin-daemon.sh start
```
8. Go back to Amazon EMR dashboard and select **Enable Web Connection**. 
9. A new window pops up. Copy the command from **Step 1: Open an SSH Tunnel to the Amazon EMR Master Node**.
10. Open a new Terminal window and paste the command from step 9 above.   
*NOTE 1: You may have to update the path to your key. I did since I stored my key in .ssh.*  
*NOTE 2: This command opens a port. It will look like the command never finishes. That is normal. Do not close or exit.*  
11. Open Chrome.
12. Click the **FoxyProxy icon** at the top right and choose **Use proxies based on their pre-defined patterns and priorities**.
13. Go back to the Amazon EMR dashboard. 
14. In the same spot you clicked **Enable Web Connection**, the word Zeppelin should appear in blue text. Click it.
15. This will open a new tab in Chrome. If all was configured properly, Zeppelin notebook should fire up.
16. Congratulations, you are done with this tutorial!

# Step 8: Set Anaconda As Default Python Interpreter In Zeppelin
1. Click **anonymous** in top right corner.
2. Click **Interpreter**.
3. Scroll down to python interpreter.
4. Click **Edit**.
4. Locate **zeppelin.python**.
6. Set value to **/home/hadoop/anaconda/bin/python**
7. All set!  
*Note: You can check by opening a new note and typing **print(sys.version)**. Make sure you are using the python interpreter!*    

# Step 9: Setup Shiro Authentication in Zeppelin
1. In EMR Terminal window, navigate to **/usr/lib/zeppelin/conf**.
2. We need to copy two templates:
    1. type **$ sudo cp shiro.ini.template shiro.ini**
    2. type **$ sudo cp zeppelin-site.xml.template zeppelin-site.xml**
3. Secure the HTTP channel 
    1. type **$ sudo nano shiro.ini**
    2. under *[urls]* make sure this is set like so:
    ```
        1. #/api/version = anon
        2. /api/interpreter/** = authc, roles[admin]
        3. /api/configurations/** = authc, roles[admin]
        4. /api/credential/** = authc, roles[admin]
        5. #/** = anon 
        6. /** = authc
        7. type control+o (to save changes)
        8. hit enter
        9. type contol+x (to exit)
     ```
4. Secure Websocket channel
    1. type **$ sudo nano zeppelin-site.xml**
    2. locate **zeppelin.anonymous.allowed**
    3. set its value to **false**
    4. simultaneously type **control o** (to save changes)
    5. hit **enter**
    6. simultaneously type **contol x** (to exit)
5. Navigate to Zeppelin directory by typing **$ cd ..**
6. Type **$ sudo bin/zeppelin-daemon.sh restart**
7. Go to Zeppelin
8. Click **Login** (top right corner)
9. Use any of these username, password combos:
```
    1. admin password1
    2. user1 password2
    3. user2 password3
```  
*Note 1: usernames, passwords, and groups can be setup in shiro.ini file.*  
*Note 2: note permissions (owners, writers, readers) can be set within note by clicking lock icon towards top right.*

# Step 10: Setup ZepplinHub
1. Go to [ZeppelinHub](https://www.zeppelinhub.com/)
2. Click blue **Register** button.
3. Fill out form and agree to *Terms of Service* and *Privacy Policy*
4. On the ZeppelinHub dashboard, locate **Zeppelin Instances** and click the **+** to the right.
5. Type an instance name and a brief description.
6. If you setup Shiro authentication, click **Include Zeppelin Credentials** and add username and password.
7. Copy **token** (and **user key** if authenticating).
8. Close window.
9. You need to set the some environment variables 
    1. type **$ cd /usr/lib/zeppelin/conf**
    2. type **$ cp zeppelin-env.sh.template zeppelin-env.sh**
    3. type **$ nano zeppelin-env.sh**
    4. Add these lines:
    ```    
    export ZEPPELIN_NOTEBOOK_STORAGE="org.apache.zeppelin.notebook.repo.VFSNotebookRepo, org.apache.zeppelin.notebook.repo.zeppelinhub.ZeppelinHubRepo"
    export ZEPPELINHUB_API_ADDRESS="https://www.zeppelinhub.com"
    export ZEPPELINHUB_API_TOKEN="YOUR_TOKEN_STRING"
    export ZEPPELINHUB_USER_KEY="YOUR_USER_KEY" (if authenticating)
    ```
    5. Save and exit
10. Navigate to zeppelin directory by typing **$ cd ..**
11. Type **sudo bin/zeppelin-daemon.sh restart**
12. Reload *ZeppelinHub*.
13. You know it worked if you click on your instance and your notebooks show up in the pane to the right.
14. Congrats! You are all done.

That's all for now. I hope you found this tutorial helpful. 
