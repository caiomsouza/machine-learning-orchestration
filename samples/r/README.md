# Machine Learning Orchestration
Pentaho’s data integration and analytics platform ends the ‘gridlock’ associated with machine learning by enabling smooth team collaboration, maximizing limited data science resources and putting predictive models to work on big data faster.

Source:<BR>
http://www.pentaho.com/machine-learning-orchestration <BR>

# What is PDI (Pentaho Data Integration)?

Pentaho Data Integration prepares and blends data to create a complete picture of your business that drives actionable insights. The platform delivers accurate, analytics-ready data to end users from any source. With visual tools to eliminate coding and complexity, Pentaho puts big data and all data sources at the fingertips of business and IT users.

Source: <BR>
http://www.pentaho.com/product/data-integration<BR>

# Machine Learning Orchestration with PDI and R

This tutorial will teach you how to integrate PDI with R.

# What is R?

R is a free software environment for statistical computing and graphics.

Source: <BR>
https://www.r-project.org/ <BR>

# What is R Studio?

RStudio is an integrated development environment (IDE) for R. It includes a console, syntax-highlighting editor that supports direct code execution, as well as tools for plotting, history, debugging and workspace management.

Source: <BR>
https://www.rstudio.com/products/RStudio/ <BR>


# What is R Script Executor?
R Script Executor for PDI: An R executor step allows an R script to be run as part of a Pentaho Data Integration transformation removing the burden of data preparation.

Source: <BR>
http://wiki.pentaho.com/display/EAI/R+script+executor<BR>

# Install R Script into PDI 7.0 EE and Windows 10 (64)

Steps:

1. Install R and R Studio (use the latest version)
2. Install rJava package using R Studio

```
install.packages('rJava')
```

3. Set Environment variables for R:

Use the command below in R Studio in order to find out your R_HOME, R_LIBS_USER variables;

```
Sys.getenv("R_HOME")
Sys.getenv("R_LIBS_USER")

```

In my case my variables are:

```
> Sys.getenv("R_HOME")
[1] "C:/PROGRA~1/R/R-33~1.1"
> Sys.getenv("R_LIBS_USER")
[1] "C:/Users/csouza/Documents/R/win-library/3.3"
> 
```

Set up the variables in your Windows Machine like the images below:

![Windows Variables Screen](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r7.PNG)

R_HOME

![Configing R_HOME](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r8.PNG)

R_LIBS_USER

![Configing R_LIBS_USER](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r9.PNG)

PATH 

![Configing PATH](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r10.PNG)


4. Install pentaho-r-plugin in /data-integration/plugins/steps folder  (find plugin in attachments)

If you are using Pentaho Data Integration 7.0 EE you can skip this step because this version already comes with a step called R Script.

5. Copying jri.dll from R to PDI

32 bits - Copy /rJava/jri/i386/jri.dll file (for 32 bit system) to /data-integration/libswt/win32

64 bits - Copy /rJava/jri/x64/jri.dll file (for 64 bit system) to /data-integration/libswt/win64

Real example: 
Copy C:\Users\csouza\Documents\R\win-library\3.3\rJava\jri\x64\jri.dll (for 64 bit system) 

![From R](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r6.PNG)

to C:\Pentaho\pentaho-ee-7.0.0.2-52-x64\design-tools\data-integration\libswt\win64

![To PDI]( https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r5.PNG )


6. Restart PDI

7. Try R Script Executor Step located in the statistics folder

In statistics step, you can find R script Executor step.
If you have any question you can ask me or else you can drop me email:

Real Example:
![R Script Executor Step](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r.PNG)


# References for Setup PDI with R
http://wiki.pentaho.com/display/EAI/R+script+executor <BR>
http://biwithui.blogspot.co.uk/2015/05/r-integration-with-pdi.html <BR>
http://www.prnewswire.com/news-releases/pentaho-data-science-pack-operationalizes-use-of-r-and-weka-261662591.html <BR>
http://www.pentaho.com/announcement/data-science-pack <BR>
https://github.com/it4biz/pdiR <BR>
http://dekarlab.de/wp/?cat=10 <BR>


# Real Example of Learning Orchestration using PDI and R

In the example below we can see how to use PDI to create, test and run a model.

![Image 1](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r.PNG)

![Image 2](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r2.PNG)

![Image 3](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r3.PNG)

![Image 4](https://github.com/caiomsouza/pdi_labs/blob/master/src/r_script/images/pdi_integration_with_r4.PNG)


# References for the Real Example of Learning Orchestration using PDI and R
http://www.pentaho.com/machine-learning-orchestration <BR>
https://dankeeley.wordpress.com/2015/04/02/executing-r-from-pentaho-data-integration-pdi-kettle/ <BR>
https://github.com/codek/pdi-samples/tree/master/rstats <BR>
