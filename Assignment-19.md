# Assignment 19

**Problem Statement:**

In this lab we will create a Jenkins Scripted Pipeline for CI:

 - Create a Jenkins Scripted Pipeline that will kick start the CI process if a commit is made. 
 - Add a Stage in the pipeline to perform to Code stability. 
 - Add a Stage in the pipeline to perform code quality analysis. 
 - Add a Stage in the pipeline to perform code coverage analysis. 
 - Add a Stage in the pipeline to generate the report for code quality & analysis.


**Solution Approach:**

- Create a Jenkins pipeline project.
- Add Poll SCM to take care of fetching and triggering the job once the commit has been made to the codebase.
- Write the scripted pipleline code for each step.

**Pipeline Job Created:**

![Pipeline Job Created:](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_19/1_pipelinejob.png)


**Added Poll SCM to the pipleline job:**

![Added Poll SCM to the pipleline job](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_19/2_added_POLL_SCM.png)


**Added Scripted code to the pipleline job:**

![Added Scripted code to the pipleline job](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_19/3_scripted_pipeine_code.png)


**Added a sample commit to VCS:**

![Added a sample commit to VCS](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_19/4_Sample_commit.png)


**Commit fetched by the pipeline job:**

![Commit fetched by the pipeline job](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_19/5_Successful_Commit_Poll.png)


**Reports Generated:**
![Reports Generated](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_19/Report_Gen.png)

