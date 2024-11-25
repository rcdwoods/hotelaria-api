package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.EspacoDeEvento;
import com.hotelaria.hotelaria.domain.entity.Estacionamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface EstacionamentoRepository extends JpaRepository<Estacionamento, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM estacionamento WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE re FROM reserva_estacionamento re INNER JOIN estacionamento e ON re.estacionamento_id = e.id WHERE e.hotel_id = ?1",
    nativeQuery = true
  )
  void removeReservaEstacionamentosFromHotel(Long hotelId);
}
