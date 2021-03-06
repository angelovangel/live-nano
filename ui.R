
dashboardPage(
  dashboardHeader(title = "live-nano"), 
  dashboardSidebar(collapsed = FALSE,
    # sliderInput("rateThreshold", "Warn when rate exceeds",
    #             min = 0, max = 50, value = 3, step = 0.1
    # ),
    sidebarMenu(
      shinyjs::useShinyjs(),
      #menuItem("Dashboard", tabName = "dashboard"),
      #menuItem("Raw data", tabName = "rawdata"), 
      tags$hr(),
      
      shinyDirButton(id = "fastq_folder", label = "Choose ONT folder", title = "Select folder with fastq files"),
      tags$hr(),
      
      actionButton("simulate", label = "Simulate real-time"),
      tags$hr(),
      sliderInput("probfilter", "Filter by probability", min = 0, max = 1, step = 0.1, value = 0),
      shinyWidgets::sliderTextInput("abundfilter", 
                                    "Filter by abundance", 
                                    choices = c(0, 0.1, 1, 10, 20), 
                                    selected = 0, 
                                    post = "%",
                                    grid = TRUE)
      #sliderInput("abundfilter", "Filter by abundance (%)", min = 0, max = 100, step = 1, value = 0)
    )
  ),
  dashboardBody(
    tabsetPanel(
      tabPanel("dashboard",
              fluidRow(
                #valueBoxOutput("rate"),
                valueBoxOutput("treads", width = 7),
                valueBoxOutput("mreads", width = 5)
              ),
              fluidRow(
                box(
                  width = 7, status = "info", solidHeader = TRUE,
                  title = "Relative abundance",
                  bubblesOutput("abundancePlot", width = "100%", height = 500)
                ),
                box(
                  width = 5, status = "info", solidHeader = TRUE,
                  title = "Top hits",
                  formattableOutput("abundanceTable")
                )
              )
      ),
      tabPanel("rawdata",
              numericInput("maxrows", "Rows to show", 25),
              tableOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      )
    )
  )
)