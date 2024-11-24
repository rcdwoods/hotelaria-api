package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Acomodacao;
import com.hotelaria.hotelaria.domain.entity.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface AcomodacaoManutencaoRepository extends JpaRepository<Acomodacao, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM acomodacao_manutencao WHERE hotel_id = ?1",
    nativeQuery = true)
  void removeAllFromHotel(Long hotelId);
}
