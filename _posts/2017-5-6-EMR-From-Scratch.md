---
published: false
title: EMR From Scratch
---

# Motivation
This is the tutorial that I wish I had. 

This tutorial assumes that you setup an AWS account. It also assumes your region is set appropriately.

Items in **bold** are buttons you click or data input into fields or code that you type. Items in *italics* are field names.

I include the dollar sign when I'm using the Terminal. Do not actually type the dollar sign, only the code that comes after.

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
1. 

# Step 5: Create EMR Cluster w/Anaconda, Tensorflow, Theano, & Keras
1. Sign in to the AWS Management Console and open the [Amazon EMR console](https://console.aws.amazon.com/elasticmapreduce/).
2. Click **Create cluster**.
3. Click **Go to advanced options** at top.
4. We will use the latest EMR version which is 5.5.0. Select the software you want to install. For demo purpose, I will select **Hadoop 2.7.3**, **Spark 2.1.0**, and **Zeppelin 0.7.1**. Leave everything else as is.
5. Click blue **Next** button at bottom right.
6. Set the number of *Core* instances. I am using 1 so we have 1 Master and 1 Worker. You can change this after the cluster is created so don't worry if you change your mind later.
7. Click blue **Next** button at bottom right.
8. Click the folder icon next to *S3 folder*. Select **standard-deviations-demo-bucket**.
9. Click blue **Select** button.
10. Click blue **Next** button at bottom right.
11. (To Be Completed) add bootstrap script.
12. Click blue **Next** button at bottom right.
13. In *EC2 key pair*, open dropdown and select **standard-deviations-demo-key-pair**.
14. Expand *EC2 Security Groups* at middle bottom of page.
15. For *Master* use dropdown to select option ending in **(cluster_security_group)**.
16. For *Core & Task* use dropdown to select option ending in **(cluster_security_group)**.
17. Click blue **Create cluster** button at bottom right. 
18. A dashboard opens. It takes 10+ minutes for your cluster to do its thing so be patient. Your cluster is ready when your status reads *Waiting* in green.
19. Once your cluster is *Waiting*, located *Master public DNS* on your dashboard. Click on the blue text that says **SSH** to the far right of that line.
20. A new window opens. Copy the command in the grey box from step 2.
21. Open Terminal.
22. Assuming your key is located in your *home* directory, paste this command as is and hit enter. Note: if you moved your key, you will have to update the path to where your .pem file is located.
23. You will get a message saying "The authenticity of host 'long host name' can't be established. Are you sure you want to continue connecting?" This is standard. Type **yes**.
24. You are successful if you see EMR spelled out in letters very large. 
25. All done. Nothing more to see here.
