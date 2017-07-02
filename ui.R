library(shiny)

shinyUI(fluidPage(
  titlePanel("Bureaux de vote Montreuillois"),
  sidebarLayout(
    sidebarPanel(
      p("Choisissez le candidat, éventuelement abstention, blanc ou nul"),
      selectInput("candidat","Candidat",choices = list("dupont","lepen","macron","hamon","arthaud","poutou","cheminade","lassale","melenchon","asselineau","fillon","blancs","nuls","abstentions"),selected = "abstentions"),
      selectInput("nb_bureaux","Nombre de bureaux à afficher", choices = list(5,10,15,20,25))
    ),
    mainPanel(
      h3("Carte des bureaux de vote"),
      plotOutput("carte"),
      h3("Résultat par bureau"),
      plotOutput("graphique"),
      h3("Bureaux avec le meilleurs/moins bon scores :"),
      "Meilleurs :",
      textOutput("best"),
      "Moins bon :",
      textOutput("worst")
    )
  )
))