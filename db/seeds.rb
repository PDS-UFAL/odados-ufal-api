# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

gr = Sector.create({ name: "Gabinete do Reitor", abbreviation: "GR", email: "gr_teste@teste.com", responsible: "Sem Responsável" })

prograd = Sector.create({ name: "Pró-reitoria de Graduação", abbreviation: "PROGRAD", email: "amauri.barros@im.ufal.br", responsible: "Amauri da Silva Barros" })

propep = Sector.create({ name: "Pró-reitoria Pesquisa e Pós-graduação", abbreviation: "PROPEP", email: "iraildes.assuncao@propep.ufal.br", responsible: "Iraildes Pereira Assunção" })

proex = Sector.create({ name: "Pró-reitoria de Extensão", abbreviation: "PROEX", email: "proex_teste@teste.com", responsible: "Clayton Antônio Santos da Silva" })

proest = Sector.create({ name: "Pró-reitoria Estudantil", abbreviation: "PROEST", email: "alexandre@proest.ufal.br", responsible: "Alexandre Lima Marques da Silva" })

progep = Sector.create({ name: "Pró-reitoria de Gestão de pessoas e do Trabalho", abbreviation: "PROGEP", email: "wellington.pereira@progep.ufal.br", responsible: "Wellington da Silva Pereira" })

proginst = Sector.create({ name: "Pró-reitoria de Gestão Institucional", abbreviation: "PROGINST", email: "acf@reitoria.ufal.br", responsible: "Arnóbio Cavalcante Filho" })

sinfra = Sector.create({ name: "Superintendência de Infraestrutura", abbreviation: "SINFRA", email: "dilson.ferreira@fau.ufal.br", responsible: "Dilson Batista Ferreira" })

ag = Sector.create({ name: "Auditoria Geral", abbreviation: "AG", email: "Thyago.sampaio@ag.ufal.br", responsible: "Thyago Bezerra Sampaio" })

corregedoria_seccional = Sector.create({ name: "Corregedoria Seccional", abbreviation: "CS", email: "daniel.coordeiro@prograd.ufal.br", responsible: "Daniel Luiz de Melo Gomes Cordeiro" })

ouvidoria = Sector.create({ name: "Ouvidoria", abbreviation: "OUVID", email: "ouvidoria@ufal.br", responsible: "Melchior Carlos do Nascimento" })

nti = Sector.create({ name: "Núcleo de Tecnologia da Informação", abbreviation: "NTI", email: "reinaldo@nti.ufal.br", responsible: "Reinaldo Cabral Silva Filho" })

sibi = Sector.create({ name: "Sistema de Bibliotecas", abbreviation: "SIBI", email: "direção@sibi.ufal.br", responsible: "Cristiane Estevão" })

ascom = Sector.create({ name: "Assessoria de Comunicação", abbreviation: "ASCOM", email: "simoneide.araujo@ascom.ufal.br", responsible: "Simoneide Batista Araújo da Silva" })

hu = Sector.create({ name: "Hospital Universitário", abbreviation: "HU", email: "hu_teste@teste.com", responsible: "Sem Responsável" })

User.create!([
  {
    email: "gr_teste@teste.com",
    password: "@Odadosgr2022",
    password_confirmation: "@Odadosgr2022",
    sector: gr
  },
  {
    email: "amauri.barros@im.ufal.br",
    password: "@Odadosprograd2022",
    password_confirmation: "@Odadosprograd2022",
    sector: prograd
  },
  {
    email: "willamys@fis.ufal.br",
    password: "@Odadosprograd2022",
    password_confirmation: "@Odadosprograd2022",
    sector: prograd
  },
  {
    email: "erika.almeida@propep.ufal.br",
    password: "@Odadospropep2022",
    password_confirmation: "@Odadospropep2022",
    sector: propep
  },
  {
    email: "iraildes.assuncao@propep.ufal.br",
    password: "@Odadospropep2022",
    password_confirmation: "@Odadospropep2022",
    sector: propep
  },
  {
    email: "pro_ex_teste@teste.com",
    password: "@Odadosproex2022",
    password_confirmation: "@Odadosproex2022",
    sector: proex
  },
  {
    email: "alexandre@proest.ufal.br",
    password: "@Odadosproest2022",
    password_confirmation: "@Odadosproest2022",
    sector: proest
  },
  {
    email: "wellington.pereira@progep.ufal.br",
    password: "@Odadosprogep2022",
    password_confirmation: "@Odadosprogep2022",
    sector: progep
  },
  {
    email: "mariana.silva@progep.ufal.br",
    password: "@Odadosprogep2022",
    password_confirmation: "@Odadosprogep2022",
    sector: progep
  },
  {
    email: "acf@reitoria.ufal.br",
    password: "@Odadosproginst2022",
    password_confirmation: "@Odadosproginst2022",
    sector: proginst
  },
  {
    email: "jarman.aderico@proginst.ufal.br",
    password: "@Odadosproginst2022",
    password_confirmation: "@Odadosproginst2022",
    sector: proginst
  },
  {
    email: "dilson.ferreira@fau.ufal.br",
    password: "@Odadossinfra2022",
    password_confirmation: "@Odadossinfra2022",
    sector: sinfra
  },
  {
    email: "Thyago.sampaio@ag.ufal.br",
    password: "@Odadosag2022",
    password_confirmation: "@Odadosag2022",
    sector: ag
  },
  {
    email: "daniel.coordeiro@prograd.ufal.br",
    password: "@Odadoscorregedoriaseccional2022",
    password_confirmation: "@Odadoscorregedoriaseccional2022",
    sector: corregedoria_seccional
  },
  {
    email: "ouvidoria@ufal.br",
    password: "@Odadosouvidoria2022",
    password_confirmation: "@Odadosouvidoria2022",
    sector: ouvidoria
  },
  {
    email: "georgina.bomfim@ouvidoria.ufal.br",
    password: "@Odadosouvidoria2022",
    password_confirmation: "@Odadosouvidoria2022",
    sector: ouvidoria
  },
  {
    email: "reinaldo@nti.ufal.br",
    password: "@Odadosnti2022",
    password_confirmation: "@Odadosnti2022",
    sector: nti
  },
  {
    email: "bruno@nti.ufal.br",
    password: "@Odadosnti2022",
    password_confirmation: "@Odadosnti2022",
    sector: nti
  },
  {
    email: "direção@sibi.ufal.br",
    password: "@Odadossibi2022",
    password_confirmation: "@Odadossibi2022",
    sector: sibi
  },
  {
    email: "da@sibi.ufal.br",
    password: "@Odadossibi2022",
    password_confirmation: "@Odadossibi2022",
    sector: sibi
  },
  {
    email: "simoneide.araujo@ascom.ufal.br",
    password: "@Odadosascom2022",
    password_confirmation: "@Odadosascom2022",
    sector: ascom
  },
  {
    email: "raniella.lima@ascom.ufal.br",
    password: "@Odadosascom2022",
    password_confirmation: "@Odadosascom2022",
    sector: ascom
  },
  {
    email: "hu_teste@teste.com",
    password: "@Odadoshu2022",
    password_confirmation: "@Odadoshu2022",
    sector: hu
  },
])
