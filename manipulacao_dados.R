pnad <- readRDS("pnad2014.rds")

library(tidyverse)
library(lubridate) 

pnad_tratada <- pnad %>%  
  select(
    UF,
    SEXO = V0302,
    
    IDADE_ANOS = V8005,
    DIA_NASC   = V3031, 
    MES_NASC   = V3032,
    ANO_NASC   = V3033,
    
    RECEBE_APOSENTADORIA = V1251,
    TRABALHOU_SEMANA     = V9001,
    CONDICAO_ATIVIDADE   = V4704,
    HORAS_TRABALHADAS    = V4707,
    RENDIMENTO_TRABALHO  = V4718,
    CARTEIRA_ASSINADA    = V9029,
    SITUACAO_CENSITARIA  = V4728,
    ANOS_ESTUDO          = V4803
  )

pnad_final <- pnad_tratada %>%
  mutate(
    ANO_NASC = as.numeric(ANO_NASC),
    MES_NASC = as.numeric(MES_NASC),
    DIA_NASC = as.numeric(DIA_NASC),
    
    DATA_NASCIMENTO = make_date(year = ANO_NASC, month = MES_NASC, day = DIA_NASC),
    
    DATA_REFERENCIA = as.Date("2014-09-27"),
    
    IDADE = IDADE_ANOS,
    
    APOSENTADO = ifelse(RECEBE_APOSENTADORIA == 1, 1, 0),
    OCUPADO    = ifelse(TRABALHOU_SEMANA == 1, 1, 0),
    ATIVO      = ifelse(CONDICAO_ATIVIDADE == 1, 1, 0),
    HOMEM      = ifelse(SEXO == 2, 1, 0),
    RURAL      = ifelse(SITUACAO_CENSITARIA >= 4, 1, 0)
  ) 

head(pnad_final)
summary(pnad_final$IDADE)
View(pnad_final)