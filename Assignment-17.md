# Assignment 17

**Problem Statement:**

Create a declarative CD pipeline as a downstream job for Java Project.
In the last assignment published our war file into the nexus server, now we have to deploy the war file into the remote server that will take some input like 
 - .host
 -  IP, user
 -  private_key_file
 - local_file_location
 - remote_file_location
 - file_permission(optional), file_owner(optional), group_owner(optional)


**Solution Approach:**
 1. Define a Upstream job and perform actions.
 2. Define a Downstream job, define its course of tasks and link it with the Upstream job.
 3. Define triggers for the Downstream job.
 4. The downstream job is triggered only and only incase the **SUCCESSFULL** complition of the Upstream job.
 5. On **SUCCESSFULL** complition of the Upstream job the Downstream job should run fine.


**Upstream Pipeline Job:**

![Upstream Job](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/Upstreamjob.png)


**Upstream Pipeline Job: Completion Status**

![Upstream Pipeline Job: Completion Status](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/CompletionStatus_Upstream.png)


**Downstream Pipeline Job:**

![Downstream Pipeline Job](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/DownstreamJob.png)


**Downstream Pipeline Job: Parameters**

![Downstream Pipeline Job: Parameters](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/DownstreamJob_Param.png)


**Downstream Pipeline Job: Build Triggers**

![Downstream Pipeline Job: Build Triggers](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/DownstreamJob_BuildTrigers.png)


**Downstream Pipeline Job: Completion Status** 

![Downstream Pipeline Job: Completion Status](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/DownjobCompletion.png)


**War file Placement in Tomcat's WebApps Folder:** 

![War file Placement in Tomcat's WebApps Folder](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/WarPlacement.png)


**Tomcat Server:** 

![Tomcat Server](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_17/WarDeployment%20Tomcat.png)
