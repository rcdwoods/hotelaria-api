package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Transporte;
import com.hotelaria.hotelaria.domain.entity.Veiculo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface VeiculoRepository extends JpaRepository<Veiculo, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM veiculo where hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllFromHotel(Long hotelId);
}
