package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface AcomodacaoRepository extends JpaRepository<Acomodacao, Long> {
  @Query(
    value = "SELECT * FROM acomodacao a WHERE " +
      "(a.numero, a.hotel_id) NOT IN " +
      "(SELECT r.numero_acomodacao,r.hotel_id FROM reserva_acomodacao r " +
      "WHERE r.data_esperada_checkin > ?2 AND r.data_esperada_checkin < ?3 OR r.data_esperada_checkout > ?2 AND r.data_esperada_checkout < ?3" +
      ") AND a.hotel_id = ?1",
    nativeQuery = true
  )
  List<Acomodacao> retrieveAllAvailableBetween(Long hotelId, LocalDateTime from, LocalDateTime to);

  @Query(value = "SELECT * FROM acomodacao a WHERE a.hotel_id = ?1", nativeQuery = true)
  List<Acomodacao> retrieveAllByHotelId(Long hotelId);

  @Query(
    value = "SELECT * FROM acomodacao a WHERE a.numero = ?1 AND a.hotel_id = ?2",
    nativeQuery = true
  )
  Optional<Acomodacao> retrieveByNumeroAndHotel(Long numero, Long hotelId);

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO acomodacao (numero, hotel_id, valor_diaria, tipo, capacidade) VALUES (?1, ?2, ?3, ?4, ?5)",
    nativeQuery = true
  )
  void insert(Long numero, Long hotelId, BigDecimal valorDiaria, String tipo, Integer capacidade);

  @Modifying
  @Transactional
  @Query(
    value = "DELETE FROM acomodacao WHERE numero = ?1 AND hotel_id = ?2",
    nativeQuery = true
  )
  void deleteByNumeroAndHotelId(Long numero, Long hotelId);

  @Modifying
  @Transactional
  @Query(value = "DELETE FROM acomodacao WHERE hotel_id = ?1", nativeQuery = true)
  void deleteAllByHotelId(Long hotelId);

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO acomodacao_politica_de_uso (numero_acomodacao, hotel_id, politica_de_uso_id) VALUES (?1, ?2, ?3)",
    nativeQuery = true
  )
  void attachPoliticaDeUsoToAcomodacao(Long numeroAcomodacao, Long hotelId, Long politicaDeUsoId);
}
