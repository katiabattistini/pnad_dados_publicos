import pandas as pd
import os
from sqlalchemy import create_engine

# Dados de conexão
dados_conexao = (
    r"mssql+pyodbc://KRB-NITRO\SQLEXPRESS/Einstein?driver=SQL+Server&trusted_connection=yes"
)

def testar_conexao(dados_conexao):
    try:
        engine = create_engine(dados_conexao)
        with engine.connect() as connection:
            result = connection.execute("SELECT 1")
            print("Conexão bem-sucedida!")
        engine.dispose()
    except Exception as e:
        print(f"Erro na conexão: {e}")

# Testar conexão
testar_conexao(dados_conexao)

# Lista de arquivos de entrada

arquivos = [
    r'D:\katia_workbanch\einstein\PNAD_COVID_072020\PNAD_COVID_072020.csv',
    r'D:\katia_workbanch\einstein\PNAD_COVID_082020\PNAD_COVID_082020.csv',
    r'D:\katia_workbanch\einstein\PNAD_COVID_092020\PNAD_COVID_092020.csv',
    r'D:\katia_workbanch\einstein\PNAD_COVID_102020\PNAD_COVID_102020.csv'
]


# Dicionário para renomear colunas
renomear_colunas = {
    "V1008": "numero_selecao_domicilio",
    "V1012": "semana_mes",
    "V1013": "mes_pesquisa",
    "V1016": "n_entrevista",
    "V1022": "situacao_domicilio",
    "V1023": "tipo_area",
    "V1030": "projecao_populacao",
    "A001A": "papel_domicilio",
    "A001B1": "dia_nascimento",
    "A001B2": "mes_nascimento",
    "A001B3": "ano_nascimento",
    "A002": "idade_morador",
    "A003": "sexo",
    "A004": "raca",
    "A005": "escolaridade",
    "B0011": "teve_febre",
    "B0012": "teve_tosse",
    "B0013": "teve_dor_garganta",
    "B0014": "teve_dificuldade_respirar",
    "B0015": "teve_dor_cabeca",
    "B0016": "teve_dor_peito",
    "B0017": "teve_nausea",
    "B0018": "teve_nariz_entupido",
    "B0019": "teve_fadiga",
    "B00110": "teve_dor_olhos",
    "B00111": "teve_perda_cheiro",
    "B00112": "teve_dor_muscular",
    "B002": "estabelecimento_de_saude",
    "B0031": "ficou_em_casa",
    "B0032": "ligou_profissional_saude",
    "B0033": "automedicacao",
    "B0034": "remedio_orientacao_medica",
    "B0035": "visita_profissional_sus",
    "B0036": "visita_profissional_particular",
    "B0037": "outra_forma_recuperacao",
    "B0041": "atendimento_ubs",
    "B0042": "atendimento_ps_sus",
    "B0043": "atendimento_hospital_SUS",
    "B0044": "atendimento_consultorio_privado",
    "B0045": "atendimento_ps_privado",
    "B0046": "atendimento_hospital_privado",
    "B005": "internado",
    "B006": "sedado_entubado",
    "B007": "plano_saude",
    "C001": "trabalhou_ou_bico",
    "C002": "estava_afastado_trabalho",
    "C003": "motivo_afastamento",
    "C004": "continuou_remunerado",
    "C005": "tempo_afastamento",
    "C0051": "afastado_menos_um_ano",
    "C0052": "afastado_menos_dois_anos",
    "C0053": "afastado_mais_dois_anos",
    "C006": "mais_de_um_trabalho",
    "C007": "tipo_trabalho",
    "C007A": "abrangencia_trabalho",
    "C007B": "clt",
    "C007C": "cargo_funcao",
    "C007D": "principal_atividade_empresa",
    "C007E": "n_empregados",
    "C007E1": "1_5_empregados",
    "C007E2": "6_10_empregados",
    "C008": "n_horas_combinado",
    "C009": "n_horas_trabalhado",
    "C010": "remuneracao",
    "C0101": "recebia_em_dinheiro",
    "C01011": "faixa_rendimento_dinheiro",
    "C01012": "valor_dinheiro",
    "C0102": "recebia_produtos_mercadorias",
    "C01021": "faixa_rendimento_retirada_produtos",
    "C01022": "valor_produtos",
    "C0103": "recebia_em_beneficios",
    "C0104": "nao_remunerado",
    "C012": "trabalho_exercido_no_mesmo_local",
    "C013": "trabalho_remoto",
    "C014": "contribuinte_INSS",
    "C015": "procurou_trabalho",
    "C016": "motivo_nao_busca_trabalho",
    "C017A": "n_busca_mas_queria",
    "D0011": "rendimento_aposentadoria_pensao",
    "D0013": "total_recebido_com_pensao",
    "D0021": "rendiment_pessoa_externa",
    "D0023": "total_recebido_com_externo",
    "D0031": "rendimentos_bolsa_familia",
    "D0033": "total_recebido_com_bolsa",
    "D0041": "recebeu_loas",
    "D0043": "total_recebido_com_loas",
    "D0051": "auxilio_emergencial",
    "D0053": "total_recebido_com_aux_emergencial",
    "D0061": "seguro_desemprego",
    "D0063": "total_recebido_com_seguro_desemprego",
    "D0071": "outros_rendimentos",
    "D0073": "total_recebido_com_outros_rend",
    "F001": "domicilio_proprio",
    "F0021": "valor_aluguel",
    "F0022": "faixa_aluguel",
    "F0061": "quem_respondeu",
    "F006": "ordem_morador"
}

def renomear_df(df, renomear_colunas):
    df.rename(columns=renomear_colunas, inplace=True)
    return df

def padronizar_colunas(dfs):
    todas_colunas = set().union(*(df.columns for df in dfs))
    for i, df in enumerate(dfs):
        colunas_faltantes = todas_colunas - set(df.columns)
        if colunas_faltantes:
            # Mensagem informativa:
            print(f"Colunas faltantes no DataFrame {i}: {colunas_faltantes}")
        for coluna in colunas_faltantes:
            df[coluna] = None
    return dfs

def verificar_padronizacao(dfs):
    dfs = padronizar_colunas(dfs)
    colunas_referencia = dfs[0].columns
    padronizado_colunas = all((df.columns == colunas_referencia).all() for df in dfs)

    if padronizado_colunas:
        print("Todos os dataframes possuem colunas padronizadas.")
    else:
        print("Dataframes com colunas não padronizadas detectados.")
        return

    tipos_referencia = dfs[0].dtypes
    for i, df in enumerate(dfs):
        try:
            df = df.astype(tipos_referencia)
        except Exception as e:
            print(f"Erro ao padronizar tipos no DataFrame {i}: {e}")

    padronizado_tipos = all((df.dtypes == tipos_referencia).all() for df in dfs)

    if padronizado_tipos:
        print("Todos os dataframes possuem tipos de dados padronizados.")
    else:
        print("Dataframes com tipos de dados não padronizados detectados.")

    # Mostrar coluna e tipos
    for i, df in enumerate(dfs):
        print(f"\nDataFrame {i} - Colunas e Tipos:")
        print(df.dtypes)

def salvar_dataframes(dfs, arquivos):
    for i, df in enumerate(dfs):
        base_name = os.path.basename(arquivos[i])
        new_filename = os.path.join(os.path.dirname(arquivos[i]), base_name.replace(".csv", "_padronizado.csv"))
        df.to_csv(new_filename, index=False, encoding='latin1')
        print(f"DataFrame {i} salvo como: {new_filename}")

def combinar_dataframes(dfs):
    df_combinado = pd.concat(dfs, ignore_index=True)
    combined_filename = r'D:\katia_workbanch\einstein\PNAD_COVID_combinado.csv'
    df_combinado.to_csv(combined_filename, index=False, encoding='latin1')
    print(f"DataFrame combinado salvo como: {combined_filename}")

def inserir_no_sql(df, dados_conexao):
    # Criar a conexão usando sqlalchemy
    engine = create_engine(dados_conexao)
    try:
        # Inserir no banco de dados
        df.to_sql('PNAD_COVID', con=engine, if_exists='replace', index=False)
        print("Dados inseridos com sucesso no SQL Server.")
    except Exception as e:
        print(f"Erro ao inserir os dados no banco de dados: {e}")
    finally:
        engine.dispose()

def processar_arquivos(arquivos, renomear_colunas, dados_conexao):
    dfs = []
    for arquivo in arquivos:
        try:
            df = pd.read_csv(arquivo, encoding='latin1')
            df = renomear_df(df, renomear_colunas)
            dfs.append(df)
        except Exception as e:
            print(f"Erro ao ler o arquivo {arquivo}: {e}")
    
    if dfs:
        verificar_padronizacao(dfs)
        salvar_dataframes(dfs, arquivos)
        df_combinado = combinar_dataframes(dfs)
        inserir_no_sql(df_combinado, dados_conexao)
    else:
        print("Nenhum dataframe foi lido corretamente.")

# Executar o processamento
processar_arquivos(arquivos, renomear_colunas, dados_conexao)