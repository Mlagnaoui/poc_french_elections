library(pdftools)
library(stringr)


candidats <- c("DUPONT-AIGNAN","LE PEN","MACRON","HAMON","ARTHAUD","POUTOU","CHEMINADE","LASSALLE","MELENCHON","ASSELINEAU","FILLON")

data <- pdf_text("resultats-presidentielle2017-1ertour-bureaux.pdf")

resultat_par_candidat <- NULL

for(i in 1:length(data)){
  page <- data[i]
  accu <- NULL
  
  for (nom in candidats){
    accu <- c(accu,candidat_page(nom,page))
  }
  accu <- c(accu,bna(page),inscrits(page))
  resultat_par_candidat <- rbind(resultat_par_candidat,accu)
}

rm(accu,i,nom,page)

resultat_par_candidat <- cbind(1:length(data),resultat_par_candidat)

resultat_par_candidat <- as.data.frame(resultat_par_candidat)
candidats_modif <- c("dupont","lepen","macron","hamon","arthaud","poutou","cheminade","lassale","melenchon","asselineau","fillon")
names(resultat_par_candidat) <- c("bureau",candidats_modif,"blancs","nuls","abstentions","inscrits")
row.names(resultat_par_candidat) <- 1:length(data)

rm(candidats,candidats_modif,data)

###############################
###############################
library(ggmap)
library(mapproj)

bureaux <- read.csv("adresse_bureaux.csv")

coordonnees <- NULL

for (i in 1:dim(bureaux)[1]){
  coordonnees <- rbind(coordonnees,geocode(paste0(bureaux[i,2], "93100 Montreuil France")))
}


bureaux <- cbind(bureaux,latitude = coordonnees[,2],longitude = coordonnees[,1])

rm(coordonnees,i)

###############################
###############################

results_bureau <- merge(x = bureaux, y = resultat_par_candidat, by = "bureau")
rm(bureaux,resultat_par_candidat)

write.csv(results_bureau,file="resultat_tour1.csv",row.names = F)