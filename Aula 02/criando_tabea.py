import pandas as pd

# Criando um DataFrame único com os dados
data = {
    "ID_Aluno": [1, 2, 3],
    "Nome_Aluno": ['Zé das Coves', 'Zé da Manga', 'Zezinha da Cove'],
    "Data_Nascimento": ['2005-04-12', '2004-06-15', '2003-09-20'],
    "CPF_Aluno": ['123.456.789-00', '234.567.890-11', '345.678.901-22'],
    "ID_Professor": [1, 2, 1],
    "Nome_Professor": ['Diego Ramos Inácio', 'André Saraiva', 'Diego Ramos Inácio'],
    "Email_Professor": ['diego@escola.com', 'andre@escola.com', 'diego@escola.com'],
    "ID_Disciplina": [1, 2, 3],
    "Nome_Disciplina": ['Matemática', 'História', 'Geografia'],
    "ID_Sala": [1, 2, 3],
    "Numero_Sala": ['Sala 101', 'Sala 102', 'Sala 103'],
    "Capacidade_Sala": [30, 25, 35],
    "ID_Turma": [1, 2, 3],
    "Ano_Letivo": [2025, 2025, 2025],
    "Turno": ['Matutino', 'Vespertino', 'Noturno'],
    "Dia_Semana": ['Segunda', 'Terça', 'Quarta'],
    "Horario_Inicio": ['08:00', '13:30', '18:10'],
    "Horario_Fim": ['12:20', '18:00', '22:40'],
    "ID_Matricula": [1, 2, 3],
    "Data_Matricula": ['2025-02-01', '2025-02-01', '2025-02-01']
}

# Criando o DataFrame
df = pd.DataFrame(data)

# Salvando a tabela em um arquivo Excel
file_path = r"C:\Users\Diego\OneDrive - Universidade de Vassouras\Periodo 2025_1\Banco de Dados Relacional\Projetos_Banco_de_Dados_Relacional\Aula 02\excel/exemplo_ensalamento_escola.xlsx"
df.to_excel(file_path, index=False)

file_path