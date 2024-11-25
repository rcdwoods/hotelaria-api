package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Academia;
import com.hotelaria.hotelaria.domain.entity.Biblioteca;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface AcademiaRepository extends JpaRepository<Academia, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM academia WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE apu FROM academia_politica_de_uso apu INNER JOIN academia a ON apu.academia_id = a.id WHERE a.hotel_id = ?1",
    nativeQuery = true
  )
  void removePoliticasDeUsoFromHotel(Long hotelId);
}
