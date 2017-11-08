# Original from https://www.youtube.com/watch?v=sc4WxfJFvh4&list=PLyD1XCIRA3gTfulK7bZnqSkPLeSVffKpQ
# Code changed by Caio Moreno 

#install.packages("shinydashboard")

library(shinydashboard)

skin <- Sys.getenv("DASHBOARD_SKIN")
skin <- tolower(skin)
if (skin == "")
  skin <- "black"


sidebar <- dashboardSidebar(
  sidebarSearchForm(label = "Search...", "searchText", "searchButton"),
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets", badgeLabel = "new",
             badgeColor = "green"
    ),
    menuItem("Charts", icon = icon("bar-chart-o"),
      menuSubItem("Chart sub-item 1", tabName = "subitem1"),
      menuSubItem("Chart sub-item 2", tabName = "subitem2")
    ),
    menuItem("Built By", icon = icon("file-code-o"),
      href = "https://www.youtube.com/watch?v=sc4WxfJFvh4&list=PLyD1XCIRA3gTfulK7bZnqSkPLeSVffKpQ"
    )
  )
)

body <- dashboardBody(
  tabItems(
    tabItem("dashboard",
            
            # Boxes with solid headers
            fluidRow(
              # box(
              #   title = "Histogram control", width = 4, solidHeader = TRUE, status = "primary",
              #   sliderInput("count", "Count", min = 1, max = 500, value = 120)
              # ),
              box(
                title = "Enter Stock Code", width = 4, solidHeader = TRUE, status = "primary",
                #textInput("StockCode", "StockCode", value = "AAPL"),
                
                textInput("StockCode", "StockCode", value = "HTHIY"),
                
                
                radioButtons("seasonal", "Select", c(NonSeasonal = "NonSeasonal", Seasonal = "Seasonal")),
                actionButton(inputId = "click", label = "Predict")
              )
              # ,box(
              #   title = "Appearance",
              #   width = 2, solidHeader = TRUE,
              #   radioButtons("fill", "Fill", # inline = TRUE,
              #                c(None = "none", Blue = "blue", Black = "black", red = "red")
              #   )
              # ),
              # box(
              #   title = "Scatterplot control",
              #   width = 2, solidHeader = TRUE, status = "warning",
              #   selectInput("spread", "Spread",
              #               choices = c("0%" = 0, "20%" = 20, "40%" = 40, "60%" = 60, "80%" = 80, "100%" = 100),
              #               selected = "60"
              #   )
              # )
            ),
      fluidRow(
        
        box(
          title = "Auto Arima - Non Seasonal",
          status = "primary",
          plotOutput("auto.arima", height = 350),
          height = 400
        ),
        box(
          title = "Auto Arima - Non Seasonal",
          
          width = 6,
          tableOutput("auto.arima1"),
          height = 380
        )
        
      ),
      
      fluidRow(
        
        box(
          title = "Auto Arima Seasonal",
          status = "primary",
          plotOutput("arima.seasonal", height = 350),
          height = 400
        ),
        box(
          title = "Auto Arima Seasonal",
          
          width = 6,
          tableOutput("arima.seasonal1"),
          height = 380
        )
        
      )
      
      
      # ,
      # Solid backgrounds
      # fluidRow(
      #           box(
      #     title = "Distribution",
      #     status = "primary",
      #     plotOutput("plot1", height = 240),
      #     height = 300
      #   ),
      #   tabBox(
      #     height = 300,
      #     tabPanel("View 1",
      #              plotOutput("scatter1", height = 230)
      #     ),
      #     tabPanel("View 2",
      #              plotOutput("scatter2", height = 230)
      #     )
      #   
      #     )
      # 
      #   ) #fluidRow Solid backgrounds
    )
  )
)

messages <- dropdownMenu(type = "messages",
  messageItem(
    from = "Sales Dept",
    message = "Sales are steady this month."
  ),
  messageItem(
    from = "New User",
    message = "How do I register?",
    icon = icon("question"),
    time = "13:45"
  ),
  messageItem(
    from = "Support",
    message = "The new server is ready.",
    icon = icon("life-ring"),
    time = "2014-12-01"
  )
)

notifications <- dropdownMenu(type = "notifications", badgeStatus = "warning",
  notificationItem(
    text = "5 new users today",
    icon("users")
  ),
  notificationItem(
    text = "12 items delivered",
    icon("truck"),
    status = "success"
  ),
  notificationItem(
    text = "Server load at 86%",
    icon = icon("exclamation-triangle"),
    status = "warning"
  )
)

tasks <- dropdownMenu(type = "tasks", badgeStatus = "success",
  taskItem(value = 90, color = "green",
    "Documentation"
  ),
  taskItem(value = 17, color = "aqua",
    "Project X"
  ),
  taskItem(value = 75, color = "yellow",
    "Server deployment"
  ),
  taskItem(value = 80, color = "red",
    "Overall project"
  )
)

header <- dashboardHeader(
  title = "Executive Dashboard",
  messages,
  notifications,
  tasks
)

ui <- dashboardPage(header, sidebar, body, skin = skin)

server <- function(input, output) {

  
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    if (is.null(input$count) || is.null(input$fill))
      return()

    data <- histdata[seq(1, input$count)]
    color <- input$fill
    if (color == "none")
      color <- NULL
    hist(data, col = color, main = NULL)
  })
  
  
#Auto.Arima - plot here  Tile#4 
  output$auto.arima <- renderPlot({
    
  
    # if (is.null(input$StockCode))
    #   return()
    library('quantmod')
    library('ggplot2')
    library('forecast')
    library('tseries')
    #Stock <- as.character(input$StockCode)
    
    data <- eventReactive(input$click, {
      (input$StockCode) 
    })
    Stock <- as.character(data())
    print(Stock)
    #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
   # plot(AAPL$AAPL.Close)  
    Stock_df<-as.data.frame(getSymbols(Symbols = Stock, 
                                   src = "yahoo", from = "2016-01-01", env = NULL))
    Stock_df$Open = Stock_df[,1]
    Stock_df$High = Stock_df[,2]
    Stock_df$Low = Stock_df[,3]
    Stock_df$Close = Stock_df[,4]
    Stock_df$Volume = Stock_df[,5]
    Stock_df$Adj = Stock_df[,6]
    Stock_df <- Stock_df[,c(7,8,9,10,11,12)] 
    
    
    
    #plot(as.ts(Stock_df$Close))
    
    Stock_df$v7_MA = ma(Stock_df$Close, order=7)
    Stock_df$v30_MA <- ma(Stock_df$Close, order=30)
    
    #STL
    rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
    decomp_rental <- stl(rental_ma, s.window="periodic")
    #plot(decomp_rental)
    adj_rental <- seasadj(decomp_rental)
    #plot(adj_rental)
    
    
    #arima
    fit <- auto.arima(Stock_df$Close,ic="bic")
    #fit.forecast <- forecast.Arima(fit)
    fit.forecast <- forecast(fit)
    plot(fit.forecast,  main= Stock)
    fit.forecast
   
 })

       #Auto.Arima1 - plot here  Tile#5
     output$auto.arima1 <- renderTable({
     #if (is.null(input$StockCode))
     #  return()
     library('quantmod')
     library('ggplot2')
     library('forecast')
     library('tseries')

     #Stock <- as.character(input$StockCode)
      data <- eventReactive(input$click, {
        (input$StockCode)
       })
      Stock <- as.character(data())
      print(Stock)
     #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
     # plot(AAPL$AAPL.Close)
     Stock_df<-as.data.frame(getSymbols(Symbols = Stock,
                                        src = "yahoo", from = "2016-01-01", env = NULL))
     Stock_df$Open = Stock_df[,1]
     Stock_df$High = Stock_df[,2]
     Stock_df$Low = Stock_df[,3]
     Stock_df$Close = Stock_df[,4]
     Stock_df$Volume = Stock_df[,5]
     Stock_df$Adj = Stock_df[,6]
     Stock_df <- Stock_df[,c(7,8,9,10,11,12)]

     #plot(as.ts(Stock_df$Close))

     Stock_df$v7_MA = ma(Stock_df$Close, order=7)
     Stock_df$v30_MA <- ma(Stock_df$Close, order=30)

     #STL
     rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
     decomp_rental <- stl(rental_ma, s.window="periodic")
     #plot(decomp_rental)
     adj_rental <- seasadj(decomp_rental)
     #plot(adj_rental)


     #arima
     fit <- auto.arima(Stock_df$Close,ic="bic")
     #fit.forecast <- forecast.Arima(fit)
     
     fit.forecast <- forecast(fit)
     
     #plot(fit.forecast,   col = "red")
     (fit.forecast)
   })
     
     #Auto.Arima Seasonal 
     output$arima.seasonal <- renderPlot({
       if (input$seasonal == "NonSeasonal")
         return()
       library('quantmod')
       library('ggplot2')
       library('forecast')
       library('tseries')
       
       #Stock <- as.character(input$StockCode)
       data <- eventReactive(input$click, {
         (input$StockCode)
       })
       Stock <- as.character(data())
       print(Stock)
       #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
       # plot(AAPL$AAPL.Close)
       Stock_df<-as.data.frame(getSymbols(Symbols = Stock,
                                          src = "yahoo", from = "2016-01-01", env = NULL))
       Stock_df$Open = Stock_df[,1]
       Stock_df$High = Stock_df[,2]
       Stock_df$Low = Stock_df[,3]
       Stock_df$Close = Stock_df[,4]
       Stock_df$Volume = Stock_df[,5]
       Stock_df$Adj = Stock_df[,6]
       Stock_df <- Stock_df[,c(7,8,9,10,11,12)]
       
       #plot(as.ts(Stock_df$Close))
       
       Stock_df$v7_MA = ma(Stock_df$Close, order=7)
       Stock_df$v30_MA <- ma(Stock_df$Close, order=30)
       
       #STL
       rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
       decomp_rental <- stl(rental_ma, s.window="periodic")
       #plot(decomp_rental)
       adj_rental <- seasadj(decomp_rental)
       #plot(adj_rental)
       
       
       #arima
       #fit <- auto.arima(Stock_df$Close,ic="bic")
       #fit.forecast <- forecast.Arima(fit)
       #plot(fit.forecast,   col = "red")
       #(fit.forecast)
       fit_s<-auto.arima(adj_rental, seasonal=TRUE)
       
       
       #fcast_s <- forecast.Arima(fit_s, h=10)
       fcast_s <- forecast(fit_s, h=10)
       
       plot(fcast_s)
     })
     
     #Auto.Arima Seasonal 
     output$arima.seasonal1 <- renderTable({
       #if (is.null(input$StockCode))
       #  return()
       if (input$seasonal == "NonSeasonal")
         return()
       library('quantmod')
       library('ggplot2')
       library('forecast')
       library('tseries')
       
       #Stock <- as.character(input$StockCode)
       data <- eventReactive(input$click, {
         (input$StockCode)
       })
       Stock <- as.character(data())
       print(Stock)
       #getSymbols("AAPL", src = "yahoo",from="2017-07-01")
       # plot(AAPL$AAPL.Close)
       Stock_df<-as.data.frame(getSymbols(Symbols = Stock,
                                          src = "yahoo", from = "2016-01-01", env = NULL))
       Stock_df$Open = Stock_df[,1]
       Stock_df$High = Stock_df[,2]
       Stock_df$Low = Stock_df[,3]
       Stock_df$Close = Stock_df[,4]
       Stock_df$Volume = Stock_df[,5]
       Stock_df$Adj = Stock_df[,6]
       Stock_df <- Stock_df[,c(7,8,9,10,11,12)]
       
       #plot(as.ts(Stock_df$Close))
       
       Stock_df$v7_MA = ma(Stock_df$Close, order=7)
       Stock_df$v30_MA <- ma(Stock_df$Close, order=30)
       
       #STL
       rental_ma <- ts(na.omit(Stock_df$v7_MA), frequency=30)
       decomp_rental <- stl(rental_ma, s.window="periodic")
       #plot(decomp_rental)
       adj_rental <- seasadj(decomp_rental)
       #plot(adj_rental)
       
       
       #arima
       #fit <- auto.arima(Stock_df$Close,ic="bic")
       #fit.forecast <- forecast.Arima(fit)
       #plot(fit.forecast,   col = "red")
       #(fit.forecast)
      fit_s<-auto.arima(adj_rental, seasonal=TRUE)
       
      # fcast_s <- forecast.Arima(fit_s, h=10)
      fcast_s <- forecast(fit_s, h=10)
      
      fcast_s
     })
     
     
  output$scatter1 <- renderPlot({
    spread <- as.numeric(input$spread) / 100
    x <- rnorm(1000)
    y <- x + rnorm(1000) * spread
    plot(x, y, pch = ".", col = "blue")
  })

  output$scatter2 <- renderPlot({
    spread <- as.numeric(input$spread) / 100
    x <- rnorm(1000)
    y <- x + rnorm(1000) * spread
    plot(x, y, pch = ".", col = "red")
  })
  
  
}

shinyApp(ui, server)

