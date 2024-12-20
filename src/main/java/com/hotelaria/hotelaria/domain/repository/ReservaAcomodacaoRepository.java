package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

public interface ReservaAcomodacaoRepository extends JpaRepository<ReservaAcomodacao, Long> {
  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO reserva_acomodacao (numero_acomodacao, hotel_id, hospede_id, data_esperada_checkin, data_esperada_checkout) VALUES (?1, ?2, ?3, ?4, ?5)",
    nativeQuery = true)
  void insert(Long numeroAcomodacao, Long hotelId, Long hospedeId, LocalDateTime dataCheckin, LocalDateTime dataCheckout);

  @Query(value = "SELECT * FROM reserva_acomodacao WHERE hospede_id = ?1", nativeQuery = true)
  List<ReservaAcomodacao> retrieveByHospedeId(Long hospedeId);

  @Query(value = "SELECT LAST_INSERT_ID()", nativeQuery = true)
  Long getLastInsertId();

  @Query(value = "DELETE FROM reserva_acomodacao WHERE numero_acomodacao = ?1 AND hotel_id = ?2", nativeQuery = true)
  void delete(Long numeroAcomodacao, Long hotelId);

  @Modifying
  @Transactional
  @Query(value = "DELETE FROM reserva_acomodacao WHERE hospede_id = ?1", nativeQuery = true)
  void removeAllFromHospede(Long hospedeId);

  @Modifying
  @Query(value = "DELETE FROM reserva_acomodacao WHERE hotel_id = ?1", nativeQuery = true)
  void removeAllFromHotel(Long hotelId);

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE reserva_acomodacao SET data_esperada_checkin = ?1, data_esperada_checkout = ?2 WHERE numero_acomodacao = ?3 AND hotel_id = ?4",
    nativeQuery = true
  )
  void update(Long numeroAcomodacao, Long hotelId, LocalDateTime dataCheckin, LocalDateTime dataCheckout);
}
