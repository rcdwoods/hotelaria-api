package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface ReservaEstacionamentoRepository extends JpaRepository<Pedido, Long> {
  @Modifying
  @Query(
    value = "DELETE re FROM reserva_estacionamento re INNER JOIN reserva_acomodacao r ON re.reserva_acomodacao_id = r.id WHERE r.hotel_id = ?1",
    nativeQuery = true)
  void removeAllFromHotel(Long hotelId);
}
