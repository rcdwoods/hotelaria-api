package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

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
  @Query(
    value = "SELECT * FROM acomodacao a WHERE a.hotel_id = ?1 AND a.numero = ?2",
    nativeQuery = true
  )
  Optional<Acomodacao> retrieveByHotelIdAndNumber(Long hotelId, Long number);
}
