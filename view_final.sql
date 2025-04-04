ALTER VIEW [dbo].[v_pnad_covid] AS
SELECT 
    T.UF,
    T.mes_pesquisa,
    T.semana_mes,
    T.idade_morador,
    T.sexo,
    T.escolaridade,
    T.plano_saude,
    T.trabalhou_ou_bico,
    T.estava_afastado_trabalho,
    T.tempo_afastamento,
    T.trabalho_remoto,
    T.auxilio_emergencial,
    T.clt,
    T.estabelecimento_de_saude,
    T.ficou_em_casa,
    T.ligou_profissional_saude,
    T.automedicacao,
    T.remedio_orientacao_medica,
    T.visita_profissional_sus,
    T.visita_profissional_particular,
    T.outra_forma_recuperacao,
    T.atendimento_ps_sus,
    T.atendimento_ubs,
    T.atendimento_hospital_SUS,
    T.atendimento_ps_privado,
    T.atendimento_hospital_privado,
    T.internado,
    T.sedado_entubado,

    -- Total de pessoas pesquisadas
    COUNT(*) AS total_pessoas,

    -- Auxílio emergencial
    SUM(CASE WHEN T.auxilio_emergencial = 1 THEN 1 ELSE 0 END) AS total_auxilio_emergencial,

    
    -- Sintomas relatados
    SUM(T.teve_febre) AS febre_casos,
    SUM(T.teve_tosse) AS tosse_casos,

    -- Total de pessoas com sintomas
    COALESCE(S.total_sintomas, 0) AS total_sintomas,

    -- Taxa de desemprego
    (SUM(CASE WHEN T.trabalhou_ou_bico = 0 THEN 1 ELSE 0 END) / CAST(COUNT(*) AS DECIMAL(10,2))) * 100 AS taxa_desemprego,

    -- Contagem de afastados
    SUM(CASE WHEN T.estava_afastado_trabalho = 1 THEN 1 ELSE 0 END) AS sum_estava_afastado_trabalho,

    -- Contagem dos que continuaram com remuneração
    SUM(CASE WHEN T.continuou_remunerado = 1 THEN 1 ELSE 0 END) AS continuou_remunerado,

    -- Contagem por tempo de afastamento
    SUM(CASE WHEN T.tempo_afastamento = 1 THEN 1 ELSE 0 END) AS afast_ate_1_mes,
    SUM(CASE WHEN T.tempo_afastamento = 2 THEN 1 ELSE 0 END) AS afast_ate_1_ano,
    SUM(CASE WHEN T.tempo_afastamento = 3 THEN 1 ELSE 0 END) AS afast_ate_2_anos,
    SUM(CASE WHEN T.tempo_afastamento = 4 THEN 1 ELSE 0 END) AS afast_mais_2_anos,

    -- Contagem por tipo de trabalho
    SUM(CASE WHEN T.tipo_trabalho = 1 THEN 1 ELSE 0 END) AS trabalhador_domestico,
    SUM(CASE WHEN T.tipo_trabalho = 2 THEN 1 ELSE 0 END) AS militar,
    SUM(CASE WHEN T.tipo_trabalho = 3 THEN 1 ELSE 0 END) AS policial_militar_bombeiro,
    SUM(CASE WHEN T.tipo_trabalho = 4 THEN 1 ELSE 0 END) AS empregado_setor_privado,
    SUM(CASE WHEN T.tipo_trabalho = 5 THEN 1 ELSE 0 END) AS empregado_setor_publico,
    SUM(CASE WHEN T.tipo_trabalho = 6 THEN 1 ELSE 0 END) AS empregador,
    SUM(CASE WHEN T.tipo_trabalho = 7 THEN 1 ELSE 0 END) AS conta_propria,
    SUM(CASE WHEN T.tipo_trabalho = 8 THEN 1 ELSE 0 END) AS trabalhador_familiar_nao_remunerado,
    SUM(CASE WHEN T.tipo_trabalho = 9 THEN 1 ELSE 0 END) AS fora_mercado_trabalho,

    -- Nomear tipo de trabalho
    CASE 
        WHEN T.tipo_trabalho = 1 THEN 'trabalhador doméstico'
        WHEN T.tipo_trabalho = 2 THEN 'militar'
        WHEN T.tipo_trabalho = 3 THEN 'policial militar/bombeiro'
        WHEN T.tipo_trabalho = 4 THEN 'empregado setor privado'
        WHEN T.tipo_trabalho = 5 THEN 'empregado setor público'
        WHEN T.tipo_trabalho = 6 THEN 'empregador'
        WHEN T.tipo_trabalho = 7 THEN 'conta própria'
        WHEN T.tipo_trabalho = 8 THEN 'trabalhador familiar não remunerado'
        WHEN T.tipo_trabalho = 9 THEN 'fora do mercado de trabalho'
        ELSE 'não especificado'
    END AS tipo_trabalho,

    -- Contagem por vínculos trabalhistas (CLT)
    SUM(CASE WHEN T.clt = 1 THEN 1 ELSE 0 END) AS carteira_assinada,
    SUM(CASE WHEN T.clt = 2 THEN 1 ELSE 0 END) AS servidor_publico_estatutario,
    SUM(CASE WHEN T.clt = 3 THEN 1 ELSE 0 END) AS sem_clt,

    -- Nomear cargo ou função
    CASE 
        WHEN T.cargo_funcao = 1 THEN 'empregado doméstico'
        WHEN T.cargo_funcao = 2 THEN 'auxiliar de limpeza'
        WHEN T.cargo_funcao = 3 THEN 'auxiliar de escritório'
        WHEN T.cargo_funcao = 4 THEN 'secretária/recepcionista'
        WHEN T.cargo_funcao = 5 THEN 'operador de telemarketing'
        WHEN T.cargo_funcao = 6 THEN 'comerciante'
        WHEN T.cargo_funcao = 7 THEN 'balconista/vendedor de loja'
        WHEN T.cargo_funcao = 8 THEN 'vendedor a domicílio'
        WHEN T.cargo_funcao = 9 THEN 'vendedor ambulante'
        WHEN T.cargo_funcao = 10 THEN 'cozinheiro/garçom'
        WHEN T.cargo_funcao = 11 THEN 'padeiro/açougueiro'
        WHEN T.cargo_funcao = 12 THEN 'agricultor/criador'
        WHEN T.cargo_funcao = 13 THEN 'auxiliar agropecuária'
        WHEN T.cargo_funcao = 14 THEN 'motorista'
        WHEN T.cargo_funcao = 15 THEN 'motorista de caminhão'
        WHEN T.cargo_funcao = 16 THEN 'motoboy'
        WHEN T.cargo_funcao = 17 THEN 'entregador de mercadorias'
        WHEN T.cargo_funcao = 18 THEN 'pedreiro/servente'
        WHEN T.cargo_funcao = 19 THEN 'mecânico de veículos'
        WHEN T.cargo_funcao = 20 THEN 'artesão/costureiro'
        WHEN T.cargo_funcao = 21 THEN 'cabeleireiro/manicure'
        WHEN T.cargo_funcao = 22 THEN 'operador de máquinas'
        WHEN T.cargo_funcao = 23 THEN 'auxiliar de produção'
        WHEN T.cargo_funcao = 24 THEN 'professor básico/superior'
        WHEN T.cargo_funcao = 25 THEN 'pedagogo/professor de idiomas'
        WHEN T.cargo_funcao = 26 THEN 'médico/enfermeiro superior'
        WHEN T.cargo_funcao = 27 THEN 'técnico de saúde médio'
        WHEN T.cargo_funcao = 28 THEN 'cuidador'
        WHEN T.cargo_funcao = 29 THEN 'segurança/vigilante'
        WHEN T.cargo_funcao = 30 THEN 'policial civil'
        WHEN T.cargo_funcao = 31 THEN 'porteiro/zelador'
        WHEN T.cargo_funcao = 32 THEN 'artista/religioso'
        WHEN T.cargo_funcao = 33 THEN 'gerente/diretor'
        WHEN T.cargo_funcao = 34 THEN 'profissão superior'
        WHEN T.cargo_funcao = 35 THEN 'técnico profissional médio'
        WHEN T.cargo_funcao = 36 THEN 'outros'
        ELSE 'não especificado'
    END AS cargo_funcao,

    -- Trabalho remoto e motivos de afastamento
    SUM(CASE WHEN T.trabalho_remoto = 1 THEN 1 ELSE 0 END) AS sum_trabalho_remoto,
    SUM(CASE WHEN T.motivo_afastamento = 1 THEN 1 ELSE 0 END) AS motivo_quarentena,
    SUM(CASE WHEN T.motivo_afastamento = 2 THEN 1 ELSE 0 END) AS motivo_ferias_folga,
    SUM(CASE WHEN T.motivo_afastamento = 3 THEN 1 ELSE 0 END) AS motivo_licenca_maternidade,
    SUM(CASE WHEN T.motivo_afastamento = 4 THEN 1 ELSE 0 END) AS motivo_licenca_saude,
    SUM(CASE WHEN T.motivo_afastamento = 5 THEN 1 ELSE 0 END) AS motivo_outro_licenca_remunerada,
    SUM(CASE WHEN T.motivo_afastamento = 6 THEN 1 ELSE 0 END) AS motivo_afastamento_nao_remunerado,
    SUM(CASE WHEN T.motivo_afastamento = 7 THEN 1 ELSE 0 END) AS motivo_fatores_ocasionais,
    SUM(CASE WHEN T.motivo_afastamento = 8 THEN 1 ELSE 0 END) AS motivo_outro_motivo,

    -- Nomear motivo de afastamento
    CASE 
        WHEN T.motivo_afastamento = 1 THEN 'quarentena'
        WHEN T.motivo_afastamento = 2 THEN 'férias/folga'
        WHEN T.motivo_afastamento = 3 THEN 'licença maternidade'
        WHEN T.motivo_afastamento = 4 THEN 'licença saúde'
        WHEN T.motivo_afastamento = 5 THEN 'outra licença remunerada'
        WHEN T.motivo_afastamento = 6 THEN 'afastamento não remunerado'
        WHEN T.motivo_afastamento = 7 THEN 'fatores ocasionais'
        WHEN T.motivo_afastamento = 8 THEN 'outro motivo'
        ELSE 'não especificado'
    END AS motivo_afastamento,

    -- Plano de saúde e estabelecimentos de saúde
    SUM(CASE WHEN T.plano_saude = 1 THEN 1 ELSE 0 END) AS com_plano,
    SUM(CASE WHEN T.plano_saude = 0 THEN 1 ELSE 0 END) AS sem_plano,
    SUM(CASE WHEN T.plano_saude = 9 THEN 1 ELSE 0 END) AS ignorado,
    SUM(CASE WHEN T.estabelecimento_de_saude = 1 THEN 1 ELSE 0 END) AS foi_est_saude

FROM 
    PNAD_COVID T
LEFT JOIN
(
    SELECT 
        UF, 
        COUNT(*) AS total_sintomas
    FROM 
        PNAD_COVID
    WHERE 
        teve_febre = 1 OR teve_tosse = 1 OR teve_dor_garganta = 1 OR 
        teve_dificuldade_respirar = 1 OR teve_dor_cabeca = 1 OR 
        teve_dor_peito = 1 OR teve_nausea = 1 OR teve_nariz_entupido = 1 OR 
        teve_fadiga = 1 OR teve_dor_olhos = 1 OR teve_perda_cheiro = 1 OR 
        teve_dor_muscular = 1
    GROUP BY 
        UF
) AS S
ON T.UF = S.UF
GROUP BY 
    T.UF, 
    T.mes_pesquisa, 
    T.semana_mes,
    T.idade_morador,
    T.sexo,
    T.escolaridade,
    T.plano_saude,
    T.trabalhou_ou_bico,
    T.estava_afastado_trabalho,
    T.tempo_afastamento,
    T.trabalho_remoto,
    T.auxilio_emergencial,
    T.clt,
    T.estabelecimento_de_saude,
    T.ficou_em_casa,
    T.ligou_profissional_saude,
    T.automedicacao,
    T.remedio_orientacao_medica,
    T.visita_profissional_sus,
    T.visita_profissional_particular,
    T.outra_forma_recuperacao,
    T.atendimento_ps_sus,
    T.atendimento_ubs,
    T.atendimento_hospital_SUS,
    T.atendimento_ps_privado,
    T.atendimento_hospital_privado,
    T.internado,
    T.sedado_entubado,
    T.tipo_trabalho,
    T.cargo_funcao,
    T.motivo_afastamento,
	S.total_sintomas