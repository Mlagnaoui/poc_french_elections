candidat_page <- function(nom,page){
  require(stringr)
  interet <- str_extract(page,pattern = paste0(nom,"([[:blank:]]+)([[:digit:]]+)([[:blank:]]+)([[:digit:]]*)(\\.*)([[:digit:]]*)%"))
  
  pourcentage <- str_extract(interet,pattern = "([[:digit:]]*)(\\.*)([[:digit:]]*)%") 
  as.numeric(sub(pattern = "%",replacement = "",pourcentage))
 
}

bna <- function(page){
  require(stringr)
  abstention <- str_extract(page,pattern = "Abstentions([[:blank:]]):([[:blank:]]+)([[:digit:]]+)([[:blank:]]+)([[:digit:]]*)(\\.*)([[:digit:]]*)%")
  abstention <- str_extract(abstention,pattern = "([[:digit:]]*)(\\.*)([[:digit:]]*)%")
  abstention <- as.numeric(sub(pattern="%",replacement = "",abstention))
  
  blanc <- str_extract(page,pattern = "Blancs([[:blank:]]):([[:blank:]]+)([[:digit:]]+)([[:blank:]]+)([[:digit:]]*)(\\.*)([[:digit:]]*)%")
  blanc <- str_extract(blanc,pattern = "([[:digit:]]*)(\\.*)([[:digit:]]*)%")
  blanc <- as.numeric(sub(pattern="%",replacement = "",blanc))
  
  nul <- str_extract(page,pattern = "Nuls([[:blank:]]):([[:blank:]]+)([[:digit:]]+)([[:blank:]]+)([[:digit:]]*)(\\.*)([[:digit:]]*)%")
  nul <- str_extract(nul,pattern = "([[:digit:]]*)(\\.*)([[:digit:]]*)%")
  nul <- as.numeric(sub(pattern="%",replacement = "",nul))
  
  c(blanc,nul,abstention)
}


inscrits <- function(page){
  require(stringr)
  insc <- str_extract(page,pattern = "Inscrits([[:blank:]]):([[:blank:]]+)([[:digit:]]+)")
  insc <- str_extract(insc,pattern = "([[:blank:]]+)([[:digit:]]+)")
  insc <- str_trim(insc,side = "both")
  as.numeric(insc)
}

