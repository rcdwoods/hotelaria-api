package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

public interface AcomodacaoRepository extends JpaRepository<Acomodacao, Long> {
  @Query(
    value = "SELECT a FROM acomodacao a WHERE " +
      "(a.numero NOT IN (SELECT numero_reserva, hotel_id FROM reserva r WHERE r.data_esperada_checkin > ?1 AND r.data_esperada_checkout < ?2) " +
      "AND ",
    nativeQuery = true
  )
  List<Acomodacao> findAllAvailableBetween(LocalDateTime from, LocalDateTime to);
}
