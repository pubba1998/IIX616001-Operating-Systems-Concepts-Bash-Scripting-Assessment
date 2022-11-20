# IIX616001 Operating Systems Concepts Bash Scripting Assessment

### Author Details
* Name: Wahalathanthrige Pubudu Dasun Perera
* Student Code: WAHAPD1
* Last Edited Timestamp: Sun, 20 Nov 2022 10:16:03 GMT 

#### Repository contains following directory structure,

* task1
  * script.sh - script related to task number one 
  * users.csv - user details required to run the script file 
* task2
  * script.sh - script related to task number two

* README.md - Markdown file that file that contains the documentation of the assessment
* BSA_Self_Assessment

### Task 1


#### Overview 

This script in task one is intend to add users to the system by reading the given csv file. The scrip will do the following tasks,

• Create a user's default password depending on the user's birthdate.  
• Create the necessary auxiliary groups (if specified and non-existent)  
• Selection of the appropriate secondary groups (if specified)  
• Make the necessary shared folder (if specified and non-existent)  
• Establish the necessary second group for the shared folder (if specified and non-existent)  
• The user's membership in a group so they can access the shared folder (if specified)  
• Establishing a connection to the users' shared folder (if specified)  
• Making a shutdown alias for the system (if user is in the sudo group)  
• Require a new password upon first login.  

To run the script a csv file should pass as an argument to the script with following details,
• The email address of the user  
• The birth date of the user (in the format YYYY/MM/DD, for example, 1991/11/17)  
• The secondary groups the user should be added to  
• A shared folder that the user requires full access to (full rwx permissions)  


Also added userLog to log the details while the execution of the script.



<b>Instruction to Run the Script </b>  

1, Login as the super user.  
2. Copy the user.csv and the script file to the same directory.  
3. Change the script to an executable file by typing the following command - 'chmod +x script.sh'  
4. Run the script by typing following command - './script.sh users.csv'  
