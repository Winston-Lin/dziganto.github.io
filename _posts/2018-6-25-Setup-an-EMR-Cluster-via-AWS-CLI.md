---
published: false
title: Setup an EMR Cluster via AWS CLI
categories: [AWS, AWS CLI, EMR, Big Data, Hadoop, JupyterHub, Spark]
---

## Objective
In this no frills post, you'll learn how to setup a big data cluster on Amazon EMR using nothing but the AWS command line. 

## Prerequisites
1. You have an AWS account.
2. You have setup a [Key Pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html#create-a-key-pair).
4. You have basic familiarity with the command line.
5. You have installed AWS CLI for [Linux](https://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html), [Mac](https://docs.aws.amazon.com/cli/latest/userguide/cli-install-macos.html) or [Windows](https://docs.aws.amazon.com/cli/latest/userguide/awscli-install-windows.html). 

## Overview
Before we dive in let's get a handle on what we need to cover. First, I'll show you the main command I typically run to setup a cluster. Then we'll break down the command to understand all the key pieces. Please note that text in CAPS is something you'll need to update with your information. For example, you'll have to provide your own key pair. So without further ado, let's dive in.

## The Command
```
aws emr create-cluster 
--release-label emr-5.14.0  
--instance-groups InstanceGroupType=MASTER,InstanceCount=1,InstanceType=m4.xlarge InstanceGroupType=CORE,InstanceCount=1,InstanceType=m4.xlarge 
--use-default-roles 
--ec2-attributes SubnetIds=subnet-YOUR_SUBNET,KeyName=YOUR_KEY 
--applications Name=JupyterHub Name=Spark Name=Hadoop 
--name=“ThisIsMyCluster” 
--log-uri s3://YOUR_BUCKET 
--steps Type=CUSTOM_JAR,Name=CustomJAR,ActionOnFailure=CONTINUE,Jar=s3://REGION.elasticmapreduce/libs/script-runner/script-runner.jar,Args=["s3://YOUR_BUCKET/YOUR_SHELL_SCRIPT.sh"]
```

## The Breakdown
That's a long command so let's break it down to see what's happening:
1. `aws emr create-cluster` - simply creates a cluster
2. `--release-label emr-5.14.0` - build a cluster with EMR version 5.14.0
3. `--instance-groups InstanceGroupType=MASTER,InstanceCount=1,InstanceType=m4.xlarge InstanceGroupType=CORE,InstanceCount=2,InstanceType=m4.xlarge` - build 1 Master node of type m4.xlarge and 2 Core nodes also of type m4.xlarge
4. `--use-default-roles` - use the default service role (EMR_DefaultRole) and instance profile (EMR_EC2_DefaultRole) for permissions to access other AWS services
5. `--ec2-attributes SubnetIds=subnet-YOUR_SUBNET,KeyName=YOUR_KEY` - configures cluster and Amazon EC2 instance configurations (you should provide a specific subnet and key here)
6. `--applications Name=JupyterHub Name=Spark Name=Hadoop` - install JupyterHub, Spark, and Hadoop on this cluster
7. `--name=“ThisIsMyCluster”` - name the cluster **ThisIsMyCluster**
8. `--log-uri s3://YOUR_BUCKET` - specify the S3 bucket where you want to store log files
9. `--steps Type=CUSTOM_JAR,Name=CustomJAR,ActionOnFailure=CONTINUE,Jar=s3://REGION.elasticmapreduce/libs/script-runner/script-runner.jar,Args=["s3://YOUR_BUCKET/YOUR_SHELL_SCRIPT.sh"]` - allows you to make additional configurations, like adding users to JupyterHub, when building the cluster (this is completely optional)

## Wrap Up
There you have it, an easy way to spin up a cluster. A few simple configuration tweaks to the command above and you'll be off and crunching data on a cluster in no time!
