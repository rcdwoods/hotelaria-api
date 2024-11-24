--- 1) O gerente do hotel deseja identificar os hóspedes que estão reservando acomodações da
-- categoria "Deluxe". Ele sabe que existem vários tipos, como "Deluxe Suite" e "Deluxe Standard",
-- e todos começam com a palavra "Deluxe".
SELECT DISTINCT p.*
FROM hospede h
         JOIN pessoa p ON p.id = h.id
         JOIN reserva_acomodacao ra ON h.id = ra.hospede_id
         JOIN acomodacao a ON ra.numero_acomodacao = a.numero AND ra.hotel_id = a.hotel_id
WHERE a.tipo LIKE 'DELUXE%';

--- 2) O gerente de um hotel deseja identificar quais acomodações estão disponíveis para reserva
-- entre o dia 01/11/2024 e 15/11/2024. Ele precisa saber quais acomodações não estão associadas
-- a nenhuma reserva cujo check-in ou check-out ocorra dentro do período selecionado. Além disso,
-- o gerente quer limitar a busca apenas às acomodações do hotel número um da rede de hotelaria.
SELECT *
FROM acomodacao a
WHERE (a.numero, a.hotel_id) NOT IN
      (SELECT r.numero_acomodacao, r.hotel_id
       FROM reserva_acomodacao r
       WHERE r.data_esperada_checkin > '2024-11-01 00:00:00' AND r.data_esperada_checkin < '2024-11-16 00:00:00'
          OR r.data_esperada_checkout > '2024-01-01 00:00:00' AND r.data_esperada_checkout < '2024-11-16 00:00:00')
  AND a.hotel_id = 1

--- 3) O gerente de RH de uma rede hoteleira deseja descobrir quais funcionários ainda não estão
-- registrados como hóspedes em nenhum hotel da rede. Ele quer usar essas informações para entender
-- melhor o envolvimento dos colaboradores com os serviços da empresa.
SELECT f.*
FROM funcionario f
         LEFT JOIN hospede h ON f.pessoa_id = h.pessoa_id
WHERE h.pessoa_id IS NULL;

--- 4) O gerente financeiro da rede hoteleira deseja identificar os hotéis que possuem uma média de
-- salários dos funcionários superior a R$ 2.600,00. Ele precisa dessa informação para analisar os
-- custos com folha de pagamento em cada unidade e planejar ações de otimização.
SELECT h.id AS hotel_id, h.nome_fantasia AS hotel_nome, AVG(ct.salario_mes) AS media_salarial
FROM hotel h
         INNER JOIN funcionario f ON h.id = f.hotel_id
         INNER JOIN contrato_de_trabalho ct ON f.id = ct.funcionario_id
GROUP BY h.id, h.nome_fantasia
HAVING AVG(ct.salario_mes) > 2600;

--- 5) O gerente de RH da rede hoteleira precisa de um relatório detalhado sobre os funcionários
-- da empresa. Este relatório deve incluir informações pessoais (nome, sexo, celular, e-mail pessoal),
-- dados corporativos (e-mail corporativo, cargo, tipo de contrato de trabalho), e informações do
-- documento de identificação (tipo e número). Além disso, ele deseja saber a carga horária mensal
-- e o salário dos funcionários para análise da equipe.
select f.id      as id_funcionario,
       p.nome,
       p.sexo,
       p.celular,
       p.email   as email_pessoal,
       f.email   as email_corporativo,
       di.tipo   as tipo_documento,
       di.numero as numero_documento,
       ct.cargo,
       ct.horas_mes,
       ct.salario_mes,
       tct.nome  as tipo_contrato_de_trabalho
from funcionario f
         inner join pessoa p on p.id = f.pessoa_id
         inner join contrato_de_trabalho ct on ct.funcionario_id = f.id
         inner join tipo_contrato_de_trabalho tct on ct.tipo_contrato_de_trabalho_id = tct.id
         inner join documento_identificacao di on di.id = p.documento_identificacao_id;

--- 6) O gerente de operações deseja identificar os hotéis que possuem salas de condomínio alugadas por empresas.
-- Ele também quer saber quais são as empresas responsáveis pelos contratos de aluguel dessas salas. A consulta
-- deve usar ao menos uma tabela desempenhando dois papéis diferentes, representando conexões distintas no modelo de banco de dados.
SELECT h.nome_fantasia AS nome_hotel,
       c.nome AS nome_condominio,
       e.razao_social AS empresa_locataria,
       ca.valor AS valor_aluguel
FROM hotel h
         JOIN condominio c ON h.id = c.hotel_id
         JOIN sala_condominio sc ON c.id = sc.condominio_id
         JOIN contrato_aluguel ca ON sc.numero = ca.numero_sala_condominio AND c.id = ca.condominio_id
         JOIN empresa e ON ca.empresa_id = e.id;
