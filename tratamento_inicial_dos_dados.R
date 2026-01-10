library(tidyverse)

arquivo_dados <- "dados_PNAD_2014/PNAD 2014/Dados/PES2014.txt" 
# Instale os dados em https://centrodametropole.fflch.usp.br/pt-br/node/8896 para tudo funcionar como esperado.


dic_pnad <- fwf_positions(
  start = c(5,  18,    27,    19,    21,    23,    530,   154,              682,                686,               702,                 307,               767,                 680),
  end   = c(6,  18,    29,    20,    22,    26,    531,   154,              682,                686,               713,                 307,               767,                 681),
  col_names = c("UF", "V0302", "V8005", "V3031", "V3032", "V3033", "V1251", "V9001", "V4704", "V4707", "V4718", "V9029", "V4728", "V4803")
)

dados_seguros <- read_fwf(
  file = arquivo_dados,
  col_positions = dic_pnad,
  col_types = cols(.default = col_double()) 
)

summary(dados_seguros$V3033) 
summary(dados_seguros$V8005) 

saveRDS(dados_seguros, "pnad2014.rds")