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
3. Basic familiarity with Python and the command line.

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
4. `conda install seaborn pandas requests`

## Get Data (SKIP)
1. `mkdir data`
2. `cd data`
3. `wget https://archive.ics.uci.edu/ml/machine-learning-databases/00280/HIGGS.csv.gz`
4. `gunzip HIGGS.csv.gz`

## Turn on FoxyProxy 	
1. Use proxies based on their pre-defined patterns and priorities

## Amazon EMR Dashboard
1. Click Enable web connection
2. Copy/paste command in new Terminal tab (opens port; looks like doesn’t complete but normal)
3. Click Zeppelin

## Update Zeppelin for Anaconda
1. Interpreters
2. Python --> CHANGE PYTHON INTERPRETER: **zeppelin.python** = `/home/hadoop/anaconda/bin/python`
3. Spark --> CHANGE SPARK INTERPRETER: **zeppelin.pyspark.python** = `/home/hadoop/anaconda/bin/python`
