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
1. Sign in to the AWS Management Console and open the Amazon [S3 console](https://console.aws.amazon.com/s3/).
2. Click **Create bucket**. A new window will open.
3. Provide a name for you bucket under *Bucket name*. The name has to be unique and has to follow AWS guidelines. My bucket name for this demo is **standard-deviations-demo-bucket**.
4. Press the **Next** button located at the bottom right. 
5. For this demo, we will assume the default values for properties and permissions are just fine, so click the **Next** button two more times. This will take you to *Review*.
6. Press **Create bucket**
7. Congratulations, you have created an S3 bucket!

# Step 2: Create A Key Pair
1. Open the Amazon [EC2 console](https://console.aws.amazon.com/ec2/).
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

# Step 4: Create EMR Cluster
