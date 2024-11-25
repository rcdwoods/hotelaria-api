package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Academia;
import com.hotelaria.hotelaria.domain.entity.EspacoDeEvento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface EspacoDeEventoRepository extends JpaRepository<EspacoDeEvento, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM espaco_de_evento WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE le FROM local_evento le INNER JOIN espaco_de_evento e ON le.espaco_evento_id = e.id WHERE e.hotel_id = ?1",
    nativeQuery = true
  )
  void removeLocaisDeEventoFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE lem FROM local_evento_manutencao lem INNER JOIN local_evento le ON lem.local_evento_id = le.id " +
      "INNER JOIN espaco_de_evento e ON le.espaco_evento_id = e.id WHERE e.hotel_id = ?1",
    nativeQuery = true
  )
  void removeManutencoesFromHotel(Long hotelId);
}
