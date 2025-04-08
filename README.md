# Análise de Dados PNAD COVID19 - 2020

## Descrição do Projeto

Este projeto consiste em uma análise exploratória dos dados públicos da pesquisa PNAD COVID19 de 2020, realizada entre julho e outubro. O objetivo é extrair insights relevantes sobre diversos aspectos da saúde e do trabalho durante a pandemia, utilizando SQL e Python para o tratamento e análise dos dados, culminando na criação de um dashboard interativo no Power BI.

# Diagrama

![Minha Imagem](diagrama.png "Diagrama do ETL")

## Tecnologias Utilizadas

- **SQL Server:** Banco de dados para armazenamento e análise dos dados.
- **Python:** Linguagem de programação utilizada para o processo de ETL (Extração, Transformação e Carga) dos dados.
- **Power BI:** Ferramenta de visualização de dados para a criação de dashboards interativos.

## Análises Exploratória de Dados e perguntas a serem respondidas

- **Análise de Cobertura de Saúde e Automedicação:** Identificação da porcentagem de automedicação entre pessoas com e sem plano de saúde, por UF.
- **Análise de Ocupação e Automedicação:** Investigação da propensão à automedicação em diferentes cargos e regimes de trabalho (CLT vs. sem vínculo formal).
- **Análise de Trabalho e Afastamento:** Relação entre afastamento do trabalho, automedicação e trabalho remoto.
- **Análise Demográfica e de Saúde:** Influência do sexo na escolha entre automedicação e tratamento convencional.
- **Análise de Sintomas e Ações de Tratamento:** Ações mais comuns para tratar sintomas, comparando automedicação e tratamento com orientação médica.


## Requisitos

- SQL Server instalado e configurado.
- Python 3.x.
- Bibliotecas Python: pandas, pyodbc.
- Power BI Desktop.

## Instruções

## Baixar arquivos da Pesquisa PNAD
- https://www.ibge.gov.br/estatisticas/sociais/saude/27947-divulgacao-mensal-pnadcovid2.html?edicao=28351&t=downloadsArquivos:
2020 :Downloads > microdados > Dados > PNAD_COVID_X2020.zip

## Estudar os dados do repositório

- o arquivo Dicionario_PNAD_COVID_052020_20220621_revisado.xls contém as informações de colunas e significados

# 1.  Clone o repositório
```bash 
git clone https://github.com/katiabattistini/pnad_dados_publicos
```
# 2. Configure a conexão com o SQL Server:

- Crie um banco de dados no SQL Server para armazenar os dados da PNAD COVID19.

# 3. Execute o script Python para ETL:

```bash
python pnad_csv_combinado.py
```
# 4. Execute o script Python para fazer a ingestão dos dados no SQL Server 

- Configure a string de conexão no script Python para apontar para o seu banco de dados.

``` bash
python pnad_to_sql.py
```
# 5. Crie view no banco de dados para ser utilizado como fonte no Power BI

```bash
view_final.sql
```

# 6. Crie relatório no Power BI deskstop
- Configure a fonte de dados para apontar para o seu banco de dados SQL Server.
- Após a instalação e configuração, você pode explorar o dashboard no Power BI para visualizar os insights gerados a partir dos dados da PNAD COVID19. O dashboard permite interagir com os dados, filtrando por diferentes dimensões e explorando os gráficos e tabelas dinâmicas

# 7. Apresentação para público não técnico
- O arquivo pnad_covid_katia_battistini.pptx foi elaborado para 

# Contato
**Kátia Battistini**

- Email: [katiaseshi@gmail.com]
- LinkedIn: [in/katiabattistini]