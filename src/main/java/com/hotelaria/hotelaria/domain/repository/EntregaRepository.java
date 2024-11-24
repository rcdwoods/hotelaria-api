package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Entrega;
import com.hotelaria.hotelaria.domain.entity.ReservaAcomodacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

public interface EntregaRepository extends JpaRepository<Entrega, Long> {
  @Modifying
  @Query(
    value = "DELETE e FROM entrega e INNER JOIN reserva_acomodacao r ON e.reserva_id = r.id WHERE r.hotel_id = ?1",
    nativeQuery = true)
  void removeAllFromHotel(Long hotelId);
}
