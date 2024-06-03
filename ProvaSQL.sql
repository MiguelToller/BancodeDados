create database prova;

create table Curso(
	idCurso int not null auto_increment,
	nome varchar(45) not null,
    area varchar(45) not null,
    PRIMARY KEY (idCurso));

create table Professor(
	idProfessor int not null auto_increment,
	nome varchar(45) not null,
    email varchar(45) not null,
    areaAtuacao varchar(45) not null,
	idCurso int not null,
    PRIMARY KEY (idProfessor),
    constraint	fk_Professor_Curso
		FOREIGN KEY (idCurso)
		references Curso(idCurso));
        
        
create table Instituicao(
	idInstituicao int not null auto_increment,
    nome varchar(45) not null,
    sigla varchar(45) not null,
    PRIMARY KEY (idInstituicao));

create table Colaborador(
	idColaborador int auto_increment,
    nome varchar(45) not null,
    PRIMARY KEY (idColaborador));


create table Projeto(
	idProjeto int not null auto_increment,
    resumo varchar(45) not null,
    titulo varchar(45) not null,
    idProfessor int not null,
    idColaborador int,
    idInstituicao int not null,
    PRIMARY KEY (idProjeto),
    constraint fk_Projeto_Professor
		FOREIGN KEY (idProfessor)
        references Professor(idProfessor),
	constraint fk_Projeto_Colaborador
		FOREIGN KEY (idColaborador)
        references Professor(idProfessor),
	constraint fk_Projeto_Instituicao
		FOREIGN KEY (idInstituicao)
        references Instituicao(idInstituicao));

insert into Curso (idCurso, nome, area)
values (1,"Ciência da Computação","Tecnologia"),
		(2,"Sistemas de Informação","Tecnologia"),
		(3,"Filosofia","Sociais");

insert into Professor (idProfessor, nome, email, idCurso, areaAtuacao)
values  (1, "Alexandre Zamberlan","alexz@ufn.edu.br",1,"Tecnologia"),
		(2, "Ana Paula","apc@ufn.edu.b",1,"Tecnologia"),
		(3, "Sylvio Garcia","sylvio@ufn.edu.br",2,"Tecnologia"),
		(4, "Mirkos Martins","mirkos@ufn.edu.br",1,"Tecnologia");
        
insert into Instituicao (idInstituicao, nome, sigla)
values (10,"Universidad Franciscana","UFN"),
		(20,"Universidade Federal de Santa Maria","UFSM");
        
insert into Projeto (idProjeto, titulo, resumo, idProfessor, idColaborador, idinstituicao)
values (1,"Web Crawler","Trabalho do Zamba",1,NULL,10),
		(2,"SirPerf","Sistema de perfusão",1,3,10),
		(3,"OdontoTren","Sistema de gestão de atendimento",2,3,20),
		(4,"Avida","Sistema de acompanhamento psiquiátrico",1,NULL,10);
        
select projeto.titulo
from projeto
where projeto.idInstituicao = "10" 
order by titulo;

select distinct Professor.nome
from Professor, Projeto
where not exists (select * from Projeto
				  where Projeto.idProfessor = Professor.idProfessor);
                  
select distinct projeto.titulo
from projeto
where projeto.idProfessor = "1";

select count(*)
from projeto;

select distinct Projeto.titulo
from Projeto
where Projeto.idColaborador is null;

select projeto.titulo
from projeto, professor
where projeto.idProfessor = Professor.idProfessor and
	  Professor.areaAtuacao = "tecnologia";
      
select distinct projeto.titulo, Curso.nome
from Projeto
inner join professor
on projeto.idProfessor = professor.idProfessor
inner join Curso
on professor.idCurso = curso.idCurso
order by projeto.titulo;
       