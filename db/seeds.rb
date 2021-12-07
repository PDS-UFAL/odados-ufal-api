# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Sector.create([
  {
    name: "GR - Gabinete do Reitor",
    email: "gr_teste@teste.com",
    responsible: "Sem Responsável"
  },
  {
    name: "PROGRAD - Pró-reitoria de Graudação",
    email: "amauri.barros@im.ufal.br",
    responsible: "Amauri da Silva Barros"
  },
  # {
  #   name: "PROGRAD - Pró-reitoria de Graudação",
  #   email: "willamys@fis.ufal.br",
  #   responsible: "Willamys Cristiano Soares Silva"
  # },
  {
    name: "PROPEP - Pró-reitoria Pesquisa e Pós-graduação",
    email: "willamys@fis.ufal.br",
    responsible: "Willamys Cristiano Soares Silva"
  },
  # {
  #   name: "PROPEP - Pró-reitoria Pesquisa e Pós-graduação",
  #   email: "willamys@fis.ufal.br",
  #   responsible: "Willamys Cristiano Soares Silva"
  # },
  {
    name: "PROEX - Pró-reitoria de Extensão",
    email: "proex_teste@teste.com",
    responsible: "Clayton Antônio Santos da Silva"
  },
  {
    name: "PROEST - Pró-reitoria Estudantil",
    email: "alexandre@proest.ufal.br",
    responsible: "Alexandre Lima Marques da Silva"
  },
  {
    name: "PROGEP - Pró-reitoria de Gestão de pessoas e do Trabalho",
    email: "wellington.pereira@progep.ufal.br",
    responsible: "Wellington da Silva Pereira"
  },
  {
    name: "PROGINST - Pró-reitoria de Gestão Institucional",
    email: "acf@reitoria.ufal.br",
    responsible: "Arnóbio Cavalcante Filho"
  },
  {
    name: "SINFRA - Superintendência de Infraestrutura",
    email: "dilson.ferreira@fau.ufal.br",
    responsible: "Dilson Batista Ferreira"
  },
  {
    name: "AG - Auditoria Geral",
    email: "Thyago.sampaio@ag.ufal.br",
    responsible: "Thyago Bezerra Sampaio"
  },
  {
    name: "Corregedoria Seccional",
    email: "daniel.coordeiro@prograd.ufal.br",
    responsible: "Daniel Luiz de Melo Gomes Cordeiro"
  },
  {
    name: "Ouvidoria",
    email: "ouvidoria@ufal.br",
    responsible: "Melchior Carlos do Nascimento"
  },
  {
    name: "NTI - Núcleo de Tecnologia da Informação",
    email: "reinaldo@nti.ufal.br",
    responsible: "Reinaldo Cabral Silva Filho"
  },
  {
    name: "SIBI - Sistema de Bibliotecas",
    email: "direção@sibi.ufal.br",
    responsible: "Cristiane Estevão"
  },
  {
    name: "ASCOM - Assessoria de Comunicação",
    email: "simoneide.araujo@ascom.ufal.br",
    responsible: "Simoneide Batista Araújo da Silva"
  },
  {
    name: "HU - Hospital Universitário",
    email: "hu_teste@teste.com",
    responsible: "Sem Responsável"
  },
])

User.create([
  {
    email: "gr_teste@teste.com",
    password: "gabinetesenhareitor",
    sector_id: 27
  },
  {
    email: "amauri.barros@im.ufal.br",
    password: "amauri123",
    sector_id: 14
  },
  {
    email: "willamys@fis.ufal.br",
    password: "willamys123",
    sector_id: 14
  },
  {
    email: "erika.almeida@propep.ufal.br",
    password: "erika123",
    sector_id: 15
  },
  {
    email: "iraildes.assuncao@propep.ufal.br",
    password: "iraildes123",
    sector_id: 15
  },
  {
    email: "pro_ex_teste@teste.com",
    password: "iraildes123",
    sector_id: 28
  },
  {
    email: "alexandre@proest.ufal.br",
    password: "alexandre123",
    sector_id: 16
  },
  {
    email: "wellington.pereira@progep.ufal.br",
    password: "wellington123",
    sector_id: 17
  },
  {
    email: "mariana.silva@progep.ufal.br",
    password: "mariana123",
    sector_id: 17
  },
  {
    email: "acf@reitoria.ufal.br",
    password: "acf123",
    sector_id: 18
  },
  {
    email: "jarman.aderico@proginst.ufal.br",
    password: "jarman123",
    sector_id: 18
  },
  {
    email: "dilson.ferreira@fau.ufal.br",
    password: "dilson123",
    sector_id: 19
  },
  {
    email: "Thyago.sampaio@ag.ufal.br",
    password: "thyago123",
    sector_id: 20
  },
  {
    email: "daniel.coordeiro@prograd.ufal.br",
    password: "daniel123",
    sector_id: 21
  },
  {
    email: "ouvidoria@ufal.br",
    password: "ouvidoria123",
    sector_id: 22
  },
  {
    email: "georgina.bomfim@ouvidoria.ufal.br",
    password: "georgina123",
    sector_id: 22
  },
  {
    email: "reinaldo@nti.ufal.br",
    password: "reinaldo123",
    sector_id: 23
  },
  {
    email: "bruno@nti.ufal.br",
    password: "bruno123",
    sector_id: 23
  },
  {
    email: "direção@sibi.ufal.br",
    password: "direcaosibi123",
    sector_id: 24
  },
  {
    email: "da@sibi.ufal.br",
    password: "dasibi123",
    sector_id: 24
  },
  {
    email: "simoneide.araujo@ascom.ufal.br",
    password: "simoneide123",
    sector_id: 25
  },
  {
    email: "raniella.lima@ascom.ufal.br",
    password: "raniella123",
    sector_id: 25
  },
  {
    email: "hu_teste@teste.com",
    password: "hu_teste123",
    sector_id: 29
  },
])