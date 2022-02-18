# A ideia aqui foi pegar dados da ANA sobre o volume útil dos reservatórios.
# O primeiro gráfico mostra a evolução ao longo do tempo para os 4 principais
# reservatórios; já o segundo gráfico mostra uma foto no final do armazenamento
# no fim de 2021 (em 28/dez)

library("tidyverse")
library("basedosdados")
library("dplyr")
library("stringr")
library(ggplot2)

## Obtém a base de dados completa da ANA
basedosdados::set_billing_id("aula2-cienciadedados")
query <- "SELECT * FROM `basedosdados.br_ana_reservatorios.sin`"
todos_reservatorios = basedosdados::read_sql(query)

#  Identifica os nomes dos reservatórios, caso queiramos trocar
#  Tentei, mas não consegui ordenar esses nomes para facitar
nomes_reserv <- todos_reservatorios %>% select("nome_reservatorio") %>% distinct

# Código para o primeiro gráfico: foram selecionados apenas 4 reservatórios
# para o gráfico não ficar poluído.
lista_reserv <- c("NOVA PONTE", "EMBORCAÇÃO", "FURNAS","SERRA DA MESA")

reserv_selec <- todos_reservatorios %>% select("nome_reservatorio", "data", "proporcao_volume_util") %>%
  filter(nome_reservatorio %in% lista_reserv, data >= "2018-01-01", str_sub(data,-2,-1)=="15")

reserv_selec %>%  
  ggplot( aes(x=data, y=proporcao_volume_util, group=nome_reservatorio, color=nome_reservatorio)) +
    geom_line(size=1) +
    labs(title = "Volume útil ao longo do tempo", y = "Proporção do volume útil (%)", x = "Data", colour = "Reservatório")

lista_reserv_dez21 <- c("NOVA PONTE", "EMBORCAÇÃO", "FURNAS","SERRA DA MESA", "ITUMBIARA", "SOBRADINHO")

reserv_selec_dez21 <- todos_reservatorios %>% select("nome_reservatorio", "data", "proporcao_volume_util") %>%
  filter(nome_reservatorio %in% lista_reserv_dez21, data == "2021-12-28")

reserv_selec_dez21 %>% 
  ggplot( aes(x=data, y=proporcao_volume_util, fill=nome_reservatorio)) +
  geom_bar(stat="identity", position = "dodge") +
  labs(title = "Volume útil dos principais reservatórios em dez/2021", y = "Proporção do volume útil (%)", colour = "Reservatório") +
  geom_text(aes(label=proporcao_volume_util), vjust=1.6, position = position_dodge(0.9), size=3.5) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank(), legend.title = element_blank())

