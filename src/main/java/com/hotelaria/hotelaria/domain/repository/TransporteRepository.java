package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Biblioteca;
import com.hotelaria.hotelaria.domain.entity.Transporte;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface TransporteRepository extends JpaRepository<Transporte, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM transporte WHERE hotel_partida_id = ?1",
    nativeQuery = true
  )
  void removeAllFromHotel(Long hotelId);
}
