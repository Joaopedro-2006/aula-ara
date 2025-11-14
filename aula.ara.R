setwd("E:\\PR_Municipios_2024\\")

  require(sf)
require(dplyr)
mapa = st_read("41MUE250GC_SIR.shp")
plot(mapa)
plot(st_geometry(mapa))
toupper

require(shiny)
#DEFININDO INTERFACE DE USUÁRIO
ui<- fluidPage(
  #PAINEL DE TÍTULO DA PÁGINA
  titlePanel("TÍTULO DA PÁGINA"),
  #TIPO DE LAYOUT
  sidebarLayout(
    #PAINEL LATERAL
    sidebarPanel(h1("MENU LATERAL"),h2("TEXTO 2"), h3("TEXTO 3")),
    #PAINEL PRINCIPAL
    mainPanel(h1("PAGINA PRINCIPAL"),h2("PRINCIPAL 2"), h3("PRINCIPAL 3"))
  )
)
#DEFININDO FUNÇÕES DO R
server<-function(input,output){
}
shinyApp(ui,server)



require(shiny)
#DEFININDO INTERFACE DE USUÁRIO
ui<- fluidPage(
  #PAINEL DE TÍTULO DA PÁGINA
  titlePanel(""),
  #TIPO DE LAYOUT
  sidebarLayout(
    #PAINEL LATERAL
    sidebarPanel("Insira seus dados Pessoais",
                 textInput(inputId="nome",label="Nome:",value=""),
                 textInput(inputId="peso",label="Peso:",value=""),
                 textInput(inputId="altura",label="Altura:",value="")
    ),
    #PAINEL PRINCIPAL
    mainPanel("")
  )
)

#DEFININDO FUNÇÕES DO R
server<-function(input,output){
  #CRIANDO OUTPUTS
  output$onome<-renderText(input$nome)
  output$opeso<-renderText(input$peso)
  output$aaltura<-renderText(input$altura)
  output$imc<-renderText({
    aux=round(as.numeric(input$peso)/(as.numeric(input$altura)^2),2)
    paste("O IMC é", aux, ".")
  })
}


#DEFININDO INTERFACE DE USUÁRIO
ui<- fluidPage(
  #PAINEL DE TÍTULO DA PÁGINA
  titlePanel(""),
  #TIPO DE LAYOUT
  sidebarLayout(
    #PAINEL LATERAL
    sidebarPanel("Insira seus dados Pessoais",
                 textInput(inputId="nome",label="Nome:",value="João"),
                 textInput(inputId="peso",label="Peso:",value="86"),
                 textInput(inputId="altura",label="Altura:",value="1.85")
    ),
    #PAINEL PRINCIPAL
    mainPanel("Resultado:",
              textOutput("onome"),
              textOutput("opeso"),
              textOutput("aaltura"),
              h4(textOutput("imc"))
    )
  )
)
shinyApp(ui,server)

require(ggplot2)
require(shiny)

dados = data.frame(diamonds)
var_names = c("PESO" = 1,
              "CORTE" = 2,
              "COR" = 3,
              "CLARIDADE" = 4, 
              "PRODUTIVIDADE" = 5,
              "TOPO" = 6,
              "PRECO" = 7,
              "COMPRIM" = 8,
              "LARGURA" = 9,
              "ESPESSURA" = 10)


ui = fluidPage(
  titlePanel("Histograma ou barras"),
  sidebarLayout(
    sidebarPanel(selectInput('variavel', 'seleciona a variavel', 
                             choices = var_names)),
    mainPanel(
      tabsetPanel(
        tabPanel("Grafico", plotOutput('grafico')),
        tabPanel("Resumo", verbatimTextOutput('descritiva')),
        tabPanel("Dados", tableOutput('topdados')),
        tabPanel("Info.", HTML("<center> <br> Fizemos tudo isso na aula de visualização! <center> <br>
                               <center> em 14/11/2025 <center>"))
      
      )
    )
  )
)


server = function(input,output) {
  output$grafico = renderPlot({
    var.escolhida = as.numeric(input$variavel)
    x = dados[,var.escolhida]
    if (is.numeric(x)){
      hist(x, 
           main = "", border = F, col = 'gold2',
           xlab = names(var_names)[var.escolhida], ylab = "freq.")
    }
    else {
      par(mar=c(4,8,1,1))
      barplot(table(x), border = F, col = 'blue3',
              xlab = names(var_names)[var.escolhida], ylab = "freq.")
    }
    })
  output$descritiva = renderPrint({
    var.escolhida = as.numeric(input$variavel)
    x = dados[,var.escolhida]
    summary(x)
  })


output$topdados = renderTable({
  var.escolhida = as.numeric(input$variavel)
  x = dados[, var.escolhida]
  head(x)
  })
}

shinyApp(ui,server)
  
   