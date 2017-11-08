
# Original from https://www.youtube.com/watch?v=sc4WxfJFvh4&list=PLyD1XCIRA3gTfulK7bZnqSkPLeSVffKpQ
# Code changed by Caio Moreno 



#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Linear Regression"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("Income",
                     "Select Income:",
                     min = 40,
                     max = 250,
                     value = 45)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         tableOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderTable({
     #CustCsv <- read.csv("c:\\R\\Customer_Age_Income.csv");
     #CustCsv <- read.csv("C:\\Users\\cmoreno\\Documents\\Labs\\Data Science & Machine Learning-20171108T133713Z-001\\Data Science _ Machine Learning\\A- Machine Learning videos 1-to-20R\\Customer_Age_Income.csv");
     
     #CustCsv <- read.csv("C:\\Users\\cmoreno\\Desktop\\Customer_Age_Income.csv");
     
     
     CustCsv <- read.csv("C:\\Users\\cmoreno\\Documents\\GitHub\\machine-learning-orchestration\\samples\\r\\code\\Shiny_Demo\\Customer_Age_Income.csv");
     
          
     

     Income_DF <- data.frame(Inc = CustCsv$Income[1:6], Spend = CustCsv$SalesAmt[1:6]);
     Income_DF
     
     Model_lm <- lm(Spend ~ Inc, data=Income_DF)
     NewInc <- data.frame(Inc=input$Income)
     NewInc
     Spend_Value <- predict(Model_lm,NewInc)
     Spend_Value
     
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


#CustCsv <- read.csv("C:\\Users\\cmoreno\\Desktop\\Customer_Age_Income.csv");
#Income_DF <- data.frame(Inc = CustCsv$Income[1:6], Spend = CustCsv$SalesAmt[1:6]);
#Income_DF



