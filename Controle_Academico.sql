create database Controle_Academico;
use Controle_Academico;

-- criando a tabela aluno

create table aluno (
cod_aluno int not null,
nome_completo varchar (150) not null,
data_nascimento date null,
cpf char (11) not null,
sexo char (1),
telefone varchar (20),
primary key(cod_aluno),
unique (cpf),
check (sexo in ('f' , 'm'))
);
describe aluno;

-- Inserindo Dados

insert into aluno (cod_aluno, nome_completo,data_nascimento, cpf , sexo, telefone) values
(1, 'Ana Clara Souza', '2002-05-14', '12345678901', 'f', '83988881111'),
(2, 'Bruno Mendes Lima', '2001-11-20', '23456789012', 'm', '83988882222'),
(3, 'Carla Dias Pereira', '2003-03-08', '34567890123', 'f', '83988883333'),
(4, 'Daniel Ribeiro Santos', '2000-08-30', '45678901234', 'm', '83988884444'),
(5, 'Eduarda Farias Rocha', '2002-01-19', '56789012345', 'f', '83988885555'),
(6, 'Felipe Gomes Martins', '1999-12-12', '67890123456', 'm', '83988886666'),
(7, 'Gabriela Torres Nunes', '2003-07-25', '78901234567', 'f', '83988887777'),
(8, 'Lucas Barbosa Castro', '2001-04-03', '89012345678', 'm', '83988888888'),
(9, 'Mariana Azevedo Costa', '2002-09-17', '90123456789', 'f', '83988889999'),
(10, 'Matheus Henrique Dias', '2000-02-28', '01234567890', 'm', '83988880000');
select *from aluno;

-- Criando a tabela curso

create table curso(
cod_curso int not null,
nome_curso varchar(150) not null,
duracao_semestres int not null,
primary key (cod_curso)
);
describe curso;

-- Inserindo dados do curso

insert into curso (cod_curso, nome_curso, duracao_semestres) values
(1, 'Medicina', 12),
(2, 'Engenharia de Software', 8),
(3, ' Administracao' , 8),
(4 , 'Direito' , 10) ,
(5 , 'Ciencia  da Computacao' , 8), 
(6, 'Engenharia Civil' , 10),
(7, 'Odontologia' , 10),
(8 , 'Medicina Veterinaria' , 10),
(9 ,' Psicologia' ,  10),
(10 ,  'Fisioterapia' , 8);
describe curso;
select *from curso;

-- Criando a tabela de disciplina

create table disciplina(
cod_disciplina int not null,
nome_disciplina varchar (150) not null,
carga_horaria int not null,
cod_curso int not null,
primary key (cod_disciplina),
foreign key (cod_curso) references curso (cod_curso)
);
describe disciplina;

-- Inserindo dados de disciplina

insert into disciplina (cod_disciplina, nome_disciplina, carga_horaria, cod_curso) values

(101, 'Anatomia Humana I' , 120, 1) ,			 -- vinculado a Medicina (cod_curso = 1)
(102 , ' Fisiologia Médica' , 100 , 1),		-- vinculado a  Medicina (cod_curso = 1)
(201 ,  ' Engenharia de requisitos' , 80 ,2), -- vinculado a Engenharia de Software (cod_curso = 2)
(202 , 'Estrutura de Dados' , 100 , 2),		 -- vinculado a Engenharia de Software (cod_curso = 2)
(301 , ' Introducao a Administracao' , 60,3), -- Vinculado a Administração (cod_curso = 3)
(302 , 'Financas Corportativas' , 80 , 3),  -- Vinculado a Administração (cod_curso = 3)
(401 , 'Direito Civil I' , 90 , 4),  		-- Vinculado a Direito (cod_curso = 4)
(501 , ' Programacao Orientada a Objetos', 100 , 5),  -- Vinculado a Ciência da Computação (cod_curso = 5)
(601, ' Resistencia dos Materiais' , 90, 6),  -- Vinculado a Engenharia Civil (cod_curso = 6)
(701 , ' Anatomia Dental' , 80 , 7),  -- Vinculado a Odontologia (cod_curso = 7)
(801 , 'Anatomia dos Animais Domesticos' , 90,8), -- Vinculado a Medicina Veterinária (cod_curso = 8)
(901 , 'Psicologia Geral' , 80 , 9), -- Vinculado a Psicologia (cod_curso = 9)
(1001 ,  'Cinesioterapia' , 80, 10); -- Vinculado a Fisioterapia (cod_curso = 10)

describe disciplina;

	-- Criando a tabela matricula
    
    create table matricula (
    
    num_matricula int not null unique,
    semestre int not null,
    ano year not null,
    cod_aluno int not null,
    cod_disciplina int not null,
    primary key (num_matricula),
    foreign key (cod_aluno) references aluno (cod_aluno),
    foreign key (cod_disciplina) references disciplina (cod_disciplina)
    );
    describe matricula;

insert into matricula (num_matricula , semestre , ano , cod_aluno, cod_disciplina) values

(10020, 3 , 2026 , 1 , 101),
(20020, 4, 2025, 2 ,  202),
(30020 ,  5 , 2024 , 3 , 302),
(40020 , 2 , 2026 , 4 , 401 ),
(50020 , 4 , 2023, 5, 501),
(60020, 4 , 2024, 6, 102),
(70020, 6 , 2027, 7 ,601),
(80020 , 2 , 2026 , 8 , 701),
(90020, 2 ,2025, 9 ,801),
(100020,2 , 2026 , 10 , 901);

 -- alteração organiza: Atualizando o ano da matrícula
 
 update matricula 
 set ano= 2027
 where num_matricula = 70020;

SELECT a.nome_completo, m.num_matricula, m.semestre, m.ano, d.nome_disciplina , c.nome_curso
FROM aluno a, matricula m, disciplina d ,curso c
WHERE a.cod_aluno = m.cod_aluno  
  AND m.cod_disciplina = d.cod_disciplina
	AND d.cod_curso= c.cod_curso;
  