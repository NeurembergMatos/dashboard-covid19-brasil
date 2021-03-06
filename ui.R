library(shinydashboard)
library(shinycssloaders)

header <- dashboardHeader(
  title = 'Coronavirus no Brasil',
  tags$li(a(href = 'http://lamfo.unb.br/index.php?lang=pt-br', target = "_blank",
            img(src = 'lamfo-logo.png',
                title = "Lamfo-UnB", height = "40px"),
            style = "padding-top:5px; padding-bottom:5px;"),
          class = "dropdown")
)

fonte_dados = tags$div(
  style='text-align:center;padding-top:25px;',
  tags$p(tags$a(
    href = 'https://coronavirus.saude.gov.br/',
    target = "_blank", 'Fonte: Ministério da Saúde',br(),
    paste('Atualização: ', date_update, sep = '')
  )
  )
)


sidebar <- dashboardSidebar(
  shiny::selectInput(inputId = 'regiao', label = 'Região', choices = regioes,
                     multiple = TRUE, selected = NULL),
  shiny::uiOutput('ui_estado'),
  shiny::uiOutput('ui_variavel'),
  shiny::uiOutput('ui_action'),
  fonte_dados
)

body <- dashboardBody(
  shiny::fluidRow(
    valueBox('Brasil: Casos confirmados', value = sumario$confirmados, icon = icon('user-md'), color = 'blue', width = 3),
    valueBox('Brasil: Casos suspeitos', value = sumario$suspeitos, width = 3, icon = icon('briefcase-medical'), color = 'light-blue'),
    valueBox('Brasil: Casos descartados', value = sumario$descartados,icon = icon('heart'), color = 'green', width = 3),
    valueBox('Brasil: Mortes', value = sumario$mortes, icon = icon('exclamation'), color = 'red',  width = 3)
    ),
  shiny::fluidRow(box(plotly::plotlyOutput('grafico'), width = 12)),
  shiny::fluidRow(box(DT::dataTableOutput('variacao'), width = 12))
  )

dashboardPage(header, sidebar, body)
