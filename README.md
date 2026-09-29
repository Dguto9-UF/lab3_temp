# Lab 3 – Sequential Logic and Counters

## Lab Specifications
Complete the lab according to the instructions posted on the course website:
[Lab 3: Sequential Logic and Counters](https://eel3701.ece.ufl.edu/assignments/labs/lab3.html)


## Getting Started with Classroom 50
This lab is submitted through **Classroom 50**.
After accepting the assignment, click the green **Code** button on your repository page, copy the **HTTPS** URL, and run:
```bash
git clone <repository-url>
```
Navigate into your repository:
```bash
cd <repository-name>
```
You are now ready to begin working.


## Repository Structure
Submit **all required files directly in the main (root) folder** of this repository.
Before submitting:

* Export your completed lab report as a PDF named:
```
lab1.pdf
```
* Ensure all required files listed in the lab instructions are included.
Refer to the lab instructions to confirm that your submission is complete.


## Git Workflow
Git tracks changes to your work and allows you to submit your files through GitHub.
You only need to clone your repository once. After that, use the following workflow whenever you make changes.


### 1. Download Updates
```bash
git pull
```
Downloads the latest version of your repository from GitHub.


### 2. Check Your Changes
```bash
git status
```
Shows which files have been modified, added, or deleted.


### 3. Stage Your Changes
```bash
git add .
```
Stages all modified and newly created files.
You may also stage specific files:
```bash
git add lab1.pdf top.bdf
```


### 4. Commit Your Work
```bash
git commit -m "Completed Part 2"
```
A commit creates a saved snapshot of your work.
Use descriptive commit messages:
```bash
git commit -m "Completed Boolean simplification"
git commit -m "Added circuit implementation"
git commit -m "Finished lab report"
```


### 5. Push Your Work to GitHub
```bash
git push
```
Uploads your committed changes to your GitHub repository.
Your work is not submitted or backed up until your changes have been successfully pushed.


## Submission Requirements
Before the deadline, verify that:
* All required files are present in your repository.
* Your lab report is exported as **labX.pdf**.
* Your latest changes have been committed.
* Your latest commit has been pushed to GitHub.
* Your files appear correctly on the GitHub webpage.
Your GitHub repository is the official submission location for this lab.


## Classroom 50 Configuration Files
This repository contains configuration files used by Classroom 50 to manage assignments and submissions.
**Do not modify, delete, rename, or move the following files or folders:**
```
.github/
.classroom50.yaml
```
These files are required for Classroom 50 functionality and help manage assignment submissions.
You should only modify files that are part of the lab assignment. If you are unsure whether a file should be changed, ask the instructor or TA before modifying it.
