---
published: false
title: From 0 to Spark Cluster in Under 10 Minutes
categories: [Amazon EMR, Apache Spark, Apache Zeppelin, Big Data]
---

![image](/assets/images/name.jpeg?raw=true){: .center-image }

## Objective
In this no frills post, you'll learn how to setup a big data cluster on Amazon EMR in less than ten minutes. 

## Prerequisites
1. You have an AWS account.
2. You have Chrome or Firefox
3. You have basic familiarity with the command line.
4. You have basic familiarity with Python. (Optional) 

## Foxy Proxy Setup
1. In Chrome or Firefox, add the **FoxyProxy** extension.
2. Restart browser after installing FoxyProxy.
3. Save [this code](https://github.com/dziganto/dziganto.github.io/blob/master/_scripts/foxyproxy-settings.xml) as **foxyproxy-settings.xml**. Keep track of where you save it.
4. In your browser, click on the `FoxyProxy icon`.
5. Click `Options`.
6. Click `Import/Export` on left-hand side.
7. Click `Choose File`. 
8. Select `foxyproxy-settings.xml`. 
9. Click `Open`.

## EMR Cluster Setup
1. Login in to AWS.

1. Create cluster button
2. Go to advanced options
3. Click Hadoop, Zeppelin, Hive, Spark
4. m4.2xlarge
5. In Hardware Configs: Root device EBS volume size = 50 
6. In Hardware Configs: 1 Master & 1 Core
7. In Hardware Configs: m4.4xlarge for Master/Slave
8. In Create Cluster - Advanced Options: add EC2 key pair
9. Create cluster button
10. Wait till it builds (“Waiting” in green)

## Amazon EMR Dashboard
1. Security group for Master (MyIP)
2. MyIP for SSH
3. SSH in

## Install Miniconda
1. `wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O ~/anaconda.sh`
2. `bash ~/anaconda.sh -b -p $HOME/anaconda`
3. `echo -e '\nexport PATH=$HOME/anaconda/bin:$PATH' >> $HOME/.bashrc && source $HOME/.bashrc`

## Turn on FoxyProxy 	
1. Open the browser with FoxyProxy installed
2. Click FoxyProxy icon
3. Click ```Use proxies based on their pre-defined patterns and priorities```

## Amazon EMR Dashboard
1. On EMR dashboard, click ```Enable web connection```
2. Copy the command at the bottom 
3. Open new Terminal tab 
4. Paste command which opens and forwards port (note: it will look like it's not working but it is so leave it alone)
3. On EMR dashboard, click Zeppelin button

## Update Zeppelin for Anaconda
1. Top right, click button with green dot
2. In drop down, select ```Interpreters```
3. Search for **python**
4. Click ```Edit```
5. Change **zeppelin.python** from ```python``` to `/home/hadoop/anaconda/bin/python`
6. Select dropdown for Interpreters again
7. Search for spark
8. Click ```Edit```
9. Change **zeppelin.pyspark.python** from ```python``` to `/home/hadoop/anaconda/bin/python`
