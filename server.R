library(shiny)

library(ggmap)
library(mapproj)
library(ggplot2)

resultats <- read.csv("resultat_tour1.csv")

carte <- get_map(location = 'montreuil',zoom=14,maptype = "terrain")



shinyServer(function(input,output){
  output$carte <- renderPlot({
    
    j <- which(names(resultats)==input$candidat)
    data <- data.frame(x=resultats[,4],y=resultats[,3],r=resultats[,j])
    ggmap(carte)+geom_point(aes(x = x,y=y,size=r),data = data,color='darkviolet')+ labs(size=input$candidat) 
    
  })
  
  output$graphique <- renderPlot({
    j <- which(names(resultats)==input$candidat)
    data <- data.frame(bureau=resultats[,1],r=resultats[,j])
  
    ggplot(data, aes(x=reorder(bureau, r), y=r)) +
      geom_point(size=3,colour="darkred") +
      theme_bw() +
      theme(panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank(),
            panel.grid.major.y = element_line(colour="grey60", linetype="dashed")) + xlab("Bureau") + ylab(paste0("score ", input$candidat))
  
  })
  
  output$best <- renderPrint({
    j <- which(names(resultats)==input$candidat)
    data <- data.frame(bureau=resultats[,1],r=resultats[,j])
    
    data <- data[order(data$r),]
    tail(data[,1],input$nb_bureaux)
  })
  
  output$worst <- renderPrint({
    j <- which(names(resultats)==input$candidat)
    data <- data.frame(bureau=resultats[,1],r=resultats[,j])
    
    data <- data[order(data$r),]
    head(data[,1],input$nb_bureaux)
  })
})



