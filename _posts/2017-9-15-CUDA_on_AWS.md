---
published: false
title: Configuring CUDA on AWS
categories: [AWS, CUDA, Deep Learning]
---
![image](/assets/images/name.jpeg?raw=true)

This is meant to be a a no frills tutorial showing you how to setup CUDA on AWS.

**Audience:** those comfortable at the command line and familiar with AWS. 

## Steps
1. On AWS, select **Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-43391926** as your Amazon Machine Image (AMI)
2. Choose **p2.xlarge** as your instance type. 
3. Configure storage, tags, and security group however you like. The defaults are just fine. The only exception is security group. Make sure you set source to **My IP** so only you have SSH access.
4. Then launch the instance.
5. 
