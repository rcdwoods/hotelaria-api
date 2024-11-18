--- Listar acomodações disponíveis de um hotel
SELECT *
FROM acomodacao a
WHERE (a.numero, a.hotel_id) NOT IN
      (SELECT r.numero_acomodacao, r.hotel_id
       FROM reserva_acomodacao r
       WHERE r.data_esperada_checkin > ?2 AND r.data_esperada_checkin < ?3
          OR r.data_esperada_checkout > ?2 AND r.data_esperada_checkout < ?3)
  AND a.hotel_id = ?1

--- Listar funcionários com todos dados úteis
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

--- Listar hoteis com quantidades de acomodações e reservas realizadas.
select distinct(h.id),
               h.nome_fantasia,
               h.setor,
               h.tamanho,
               h.is_central,
               h.categoria,
               (select count(*) from acomodacao aa where aa.hotel_id = h.id)  as `quantidade_acomodacoes`,
               (select count(*)
                from reserva_acomodacao ra
                where ra.hotel_id = h.id
                  and ((ra.data_esperada_checkin >= '2024-11-01 00:00:00' and
                        ra.data_esperada_checkin <= '2024-11-28 23:59:59') or
                       (ra.data_esperada_checkout >= '2024-11-01 00:00:00' and
                        ra.data_esperada_checkout <= '2024-11-28 23:59:59'))) as quantidade_reservas
from hotel h