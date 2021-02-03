# Assignment 25

**Problem Statement:**

Azure Assignment - 1 

### Task 1
* Consider a scenario where we would be having a front end and a backend server, as this is a controlled setup we would be having nginx running on our frontend server displaying the "ninja group name and the name of the members in it".
* We would like to access this information from our backend server only. Devise a setup with which can fulfill this requirement. 

### Task 2
* Consider a scenario where the organization has two different networks in two separate regions, the organization size is quite small so they want to restrict the number of servers(windows) in each network to 4.
* One of the server present in region B has a certain system file that you have generated via powershell which collects the information about all the processes whose status is running, we would like to get that file from region b to region A's server.
* Devise a solution to accomplish the above tasks.

# Solution Task -1 

**Functional Flow**

![Functional Flow Diagram ](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/Asg25-task1.JPG)


**Created a Vnet**

The Vnet has both the VM in the network
- Frontend VM
- Backend VM

![Vnet](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/1.jpg)


**Network Topology of the Cloud Infrastructure**

![Cloud Infrastructure](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/2.jpg)


**Frontend VM Networking**

- A thing to note here is that there are no HTTP or HTTPs port in the open state

![Frontend VM Networking](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/3.jpg)


**Backend VM Networking**

- A thing to note here is that there are SSH, HTTP and HTTPs port configured for the Backend server

![Backend VM Networking](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/4.jpg)


**ICMP Port Enabled for the Backend VM**

![ICMP](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/5.jpg)


**IP of the Backend VM**

![IP](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/6.jpg)


**Ping successful on the Backend VM**

![Ping](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/7.jpg)


**Fronend VM IP Address**

![Fronend](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/8.jpg)


**Fronend VM Rule details**

- A thing to note here is that there are the incomming traffic are the subnet IPs of the Backend VM

![Fronend](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/FE_Port_config.jpg)


**Fronend VM Rule added**

- A thing to note here is that there are the incomming traffic are the subnet IPs of the Backend VM

![Fronend](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/9.jpg)


**Accessing Backend VM via Putty**

![Backend](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/10.jpg)


**Pinging Frontend VM through Backend VM in Putty**

- A thing to note is that we are using the ssh connection to access the Frontend VM via Backend VM

![Frontend](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/11.JPG)


**Accessing Frontend VM through Backend VM in Putty**

- A thing to note is that we are using the ssh connection to access the Frontend VM via Backend VM

![Frontend](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/12.JPG)


**Installed Nginx on Frontend via by ssh**

![Nginx](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/13.JPG)


**Accessing the website from Backend via curl command**

![Nginx](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/new/14.JPG)


**Task Completion**

![Completion](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/Task-1_Achieved.jpg)

# Solution Task -2


**Two different Vnets and VMs created**

![Two different Vnets and VMs created](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/01-V_nets_&_VM_created.jpg)


**Network Topology**

![Network Topology](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/02-Nw-Toplology.JPG)


**VM-01 Settings**
![VM-01 Settings](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/03-VM-01_Settings.jpg)


**VM-02 Settings**
![VM-02 Settings](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/04-VM-04_Settings.jpg)


**VM-01 Putty Access**
![VM-01 Putty Access](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/05-VM-01_Accessed_via_putty.jpg)


**VM-02 Putty Access**
![VM-02 Putty Access](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/06-VM-04_Accessed_via_putty.jpg)


**VM-02: Dummy File created**
![VM-02: Dummy File](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/07-Created_dummy_file.jpg)


**VM-01: Dummy File fetched**
![VM-01: Dummy File](https://gitlab.com/ot-devops-ninja/batch9/linux/linux-batch-9-solutions/-/raw/siddharth/img/img_Asg_25/part-2/08-File-fetched.jpg)
