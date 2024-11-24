package com.hotelaria.hotelaria.domain.repository;

import com.hotelaria.hotelaria.domain.entity.Condominio;
import com.hotelaria.hotelaria.domain.entity.Entrega;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface CondominioRepository extends JpaRepository<Condominio, Long> {
  @Modifying
  @Query(
    value = "DELETE FROM condominio WHERE hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllFromHotel(Long hotelId);
  @Modifying
  @Query(
    value = "DELETE sc FROM sala_condominio sc INNER JOIN condominio c ON c.id = sc.condominio_id WHERE c.hotel_id = ?1",
    nativeQuery = true
  )
  void removeAllSalasFromHotel(Long hotelId);

  @Modifying
  @Query(
    value = "DELETE ca FROM contrato_aluguel ca INNER JOIN condominio c ON ca.condominio_id = c.id WHERE c.hotel_id = ?1",
    nativeQuery = true
  )
  void removeContratosAluguelFromHotel(Long hotelId);

  @Modifying
  @Query(
    value = "DELETE scm FROM sala_condominio_manutencao scm INNER JOIN condominio c ON scm.condominio_id = c.id WHERE c.hotel_id = ?1",
    nativeQuery = true
  )
  void removeSalasCondominioManutencaoFromHotel(Long hotelId);
}
