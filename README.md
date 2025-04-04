# Análise de Dados PNAD COVID19 - 2020

## Descrição do Projeto

Este projeto consiste em uma análise exploratória dos dados públicos da pesquisa PNAD COVID19 de 2020, realizada entre julho e outubro. O objetivo é extrair insights relevantes sobre diversos aspectos da saúde e do trabalho durante a pandemia, utilizando SQL e Python para o tratamento e análise dos dados, culminando na criação de um dashboard interativo no Power BI.

## Tecnologias Utilizadas

- **SQL Server:** Banco de dados para armazenamento e análise dos dados.
- **Python:** Linguagem de programação utilizada para o processo de ETL (Extração, Transformação e Carga) dos dados.
- **Power BI:** Ferramenta de visualização de dados para a criação de dashboards interativos.

## Funcionalidades

- **Análise de Cobertura de Saúde e Automedicação:** Identificação da porcentagem de automedicação entre pessoas com e sem plano de saúde, por UF.
- **Análise de Ocupação e Automedicação:** Investigação da propensão à automedicação em diferentes cargos e regimes de trabalho (CLT vs. sem vínculo formal).
- **Análise de Trabalho e Afastamento:** Relação entre afastamento do trabalho, automedicação e trabalho remoto.
- **Análise Demográfica e de Saúde:** Influência do sexo na escolha entre automedicação e tratamento convencional.
- **Análise de Sintomas e Ações de Tratamento:** Ações mais comuns para tratar sintomas, comparando automedicação e tratamento com orientação médica.
- **Dashboard Interativo no Power BI:** Visualização dos dados e insights gerados através de gráficos e tabelas dinâmicas.

## Requisitos

- SQL Server instalado e configurado.
- Python 3.x.
- Bibliotecas Python: pandas, pyodbc.
- Power BI Desktop.

## Instalação

## 1 . Clone o repositório

## Configure a conexão com o SQL Server:

- Crie um banco de dados no SQL Server para armazenar os dados da PNAD COVID19.
- Configure a string de conexão no script Python para apontar para o seu banco de dados.

## Execute o script Python para ETL:

```bash
python etl_pnad_covid19.py
Abra o arquivo Power BI:
Abra o arquivo dashboard_pnad_covid19.pbix no Power BI Desktop.
Configure a fonte de dados para apontar para o seu banco de dados SQL Server.
Uso
Após a instalação e configuração, você pode explorar o dashboard no Power BI para visualizar os insights gerados a partir dos dados da PNAD COVID19. O dashboard permite interagir com os dados, filtrando por diferentes dimensões e explorando os gráficos e tabelas dinâmicas.

Contribuição
Contribuições são bem-vindas! Se você tiver alguma sugestão de melhoria, correção de bugs ou novas análises, siga os passos abaixo:

Faça um fork do repositório.
Crie uma branch com a sua feature: git checkout -b feature/nova-analise.
Faça commit das suas alterações: git commit -am 'Adiciona nova análise'.
Faça push para a branch: git push origin feature/nova-analise.
Abra um Pull Request.
Licença
Este projeto está licenciado sob a 

opensource.org
.

Contato
Kátia Battistini

Email: [seu email]
LinkedIn: [seu LinkedIn]