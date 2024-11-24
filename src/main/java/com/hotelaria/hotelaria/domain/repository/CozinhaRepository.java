package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Condominio;
import com.hotelaria.hotelaria.domain.entity.Cozinha;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface CozinhaRepository extends JpaRepository<Cozinha, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM cozinha WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeFromHotel(Long hotelId);
}
