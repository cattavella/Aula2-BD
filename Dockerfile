
FROM rocker/tidyverse

WORKDIR "./Aula2-BD"

RUN R -e "install.packages('stringr')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('basedosdados')"

COPY "./Aula2-Reservatorios.R"			"./Aula2-Reservatorios.R"

CMD Rscript "./Aula2-Reservatorios.R"


