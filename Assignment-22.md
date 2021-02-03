# Assignment 22

**Problem Statement:**

**Part A**
- Modify the existing shared library to execute Code quality, Code bugscan(using findbugs) in the parallel stage. 
- Visualize the stage view with the BlueOcean plugin in Jenkins. 

**Part B**
- Add another option in the property file to publish the artifact on Nexus. _**(Pending)**_
- Create another scripted pipeline to deploy the war file to the tomcat server. In this job, the parameter should list artifacts directly from Nexus. _**(Pending)**_

**Solution Approach - Part A**
- Create the scripted pipeline to execute the two tasks in parallel.


**Create a Pipeline Job:**

![Pipeline Job](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_22/1_createPipelineJob.png)


**Create Scripted Pipeline**

![Scripted Pipeline](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_22/2_create_pipeline.png)


**Build Step of the Job**

![Job Build](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_22/3_build.png)


**Blue Ocean Snap**

![Blue Ocean Snap](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_22/4_BlueOcean_Snap.png)
